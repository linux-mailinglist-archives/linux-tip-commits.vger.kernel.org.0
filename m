Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21649200361
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jun 2020 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgFSIQG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Jun 2020 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbgFSIQD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Jun 2020 04:16:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCCC06174E;
        Fri, 19 Jun 2020 01:16:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmCBr-0003oi-CT; Fri, 19 Jun 2020 10:15:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CD4D91C032F;
        Fri, 19 Jun 2020 10:15:58 +0200 (CEST)
Date:   Fri, 19 Jun 2020 08:15:58 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Provide elf_write_{insn,reloc}()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159255455853.16989.2223578033878947648.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fdabdd0b05e0bdf232340d5da86563ed142a99a7
Gitweb:        https://git.kernel.org/tip/fdabdd0b05e0bdf232340d5da86563ed142a99a7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 12 Jun 2020 15:43:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Jun 2020 17:36:33 +02:00

objtool: Provide elf_write_{insn,reloc}()

This provides infrastructure to rewrite instructions; this is
immediately useful for helping out with KCOV-vs-noinstr, but will
also come in handy for a bunch of variable sized jump-label patches
that are still on ice.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c | 40 +++++++++++++++++++++++++++++++++++++++-
 tools/objtool/elf.h |  7 ++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index bc6723a..26d11d8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -529,8 +529,9 @@ static int read_relas(struct elf *elf)
 			rela->addend = rela->rela.r_addend;
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
-			rela->sym = find_symbol_by_index(elf, symndx);
 			rela->sec = sec;
+			rela->idx = i;
+			rela->sym = find_symbol_by_index(elf, symndx);
 			if (!rela->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
@@ -784,6 +785,43 @@ int elf_rebuild_rela_section(struct elf *elf, struct section *sec)
 	return 0;
 }
 
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn)
+{
+	Elf_Data *data = sec->data;
+
+	if (data->d_type != ELF_T_BYTE || data->d_off) {
+		WARN("write to unexpected data for section: %s", sec->name);
+		return -1;
+	}
+
+	memcpy(data->d_buf + offset, insn, len);
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+
+	elf->changed = true;
+
+	return 0;
+}
+
+int elf_write_rela(struct elf *elf, struct rela *rela)
+{
+	struct section *sec = rela->sec;
+
+	rela->rela.r_info = GELF_R_INFO(rela->sym->idx, rela->type);
+	rela->rela.r_addend = rela->addend;
+	rela->rela.r_offset = rela->offset;
+
+	if (!gelf_update_rela(sec->data, rela->idx, &rela->rela)) {
+		WARN_ELF("gelf_update_rela");
+		return -1;
+	}
+
+	elf->changed = true;
+
+	return 0;
+}
+
 int elf_write(struct elf *elf)
 {
 	struct section *sec;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index aa9c64d..7324e77 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -64,9 +64,10 @@ struct rela {
 	GElf_Rela rela;
 	struct section *sec;
 	struct symbol *sym;
-	unsigned int type;
 	unsigned long offset;
+	unsigned int type;
 	int addend;
+	int idx;
 	bool jump_table_start;
 };
 
@@ -119,6 +120,10 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 void elf_add_rela(struct elf *elf, struct rela *rela);
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn);
+int elf_write_rela(struct elf *elf, struct rela *rela);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
