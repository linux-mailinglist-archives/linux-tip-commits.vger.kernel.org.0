Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3AE42CCFC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Oct 2021 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJMVos (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Oct 2021 17:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhJMVos (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Oct 2021 17:44:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A661C061570;
        Wed, 13 Oct 2021 14:42:44 -0700 (PDT)
Date:   Wed, 13 Oct 2021 21:42:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634161363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcz9lVbGUiJsueFNmChr4OYGIEn2faDTHfkxSoHFPuo=;
        b=DrdSKKb2EuFmq+xC3FAoA6DsDv+PSjkBf2bxYPiq6DKRiCj/KXnPmQPuA/pbBKVNgsCth8
        S6qVNIKN7QN+5q+l60zN2GSMgFpg+8GybYD24EKbDRMewcc+PLGPhq4DndjiuCThfvyJeg
        vfAWKJBBL8BFh0oSsuiuhKOqhqI+tPfU0kpJilb8ICNAOsuQ/RKSdH1w5FNnDiE64Wl9+0
        of/RO/jirYr2nJiqQmxsy4e76YtIuM3l//BWHgCljtEOMVtfMCOKIYWRnwhiJug8/S3lW7
        x25yCyVsw+6ETxPP1rDOGcXdNQoxPXqJzVF8ju0bPpcsgTEtyYyotzMc2BoJgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634161363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcz9lVbGUiJsueFNmChr4OYGIEn2faDTHfkxSoHFPuo=;
        b=XbNb43RjXtlIJlPfthPc83ZKb8tC5f8lxU8YIr8GkZMnoyLtQtGrrBfAmFkKcAudZHALyW
        ZC3QpRQlecZoYWAQ==
From:   "tip-bot2 for Michael Forney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Check for gelf_update_rel[a] failures
Cc:     Michael Forney <mforney@mforney.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210509000103.11008-1-mforney@mforney.org>
References: <20210509000103.11008-1-mforney@mforney.org>
MIME-Version: 1.0
Message-ID: <163416136222.25758.15837995452727110892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     b46179d6bb3182c020f2bf9bb4df6ba5463b0495
Gitweb:        https://git.kernel.org/tip/b46179d6bb3182c020f2bf9bb4df6ba5463b0495
Author:        Michael Forney <mforney@mforney.org>
AuthorDate:    Sat, 08 May 2021 17:01:02 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 06 Oct 2021 20:11:53 -07:00

objtool: Check for gelf_update_rel[a] failures

Otherwise, if these fail we end up with garbage data in the
.rela.orc_unwind_ip section, leading to errors like

  ld: fs/squashfs/namei.o: bad reloc symbol index (0x7f16 >= 0x12) for offset 0x7f16d5c82cc8 in section `.orc_unwind_ip'

Signed-off-by: Michael Forney <mforney@mforney.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20210509000103.11008-1-mforney@mforney.org
---
 tools/objtool/elf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b18f005..d1d4491 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1001,7 +1001,10 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		gelf_update_rel(sec->data, idx, &reloc->rel);
+		if (!gelf_update_rel(sec->data, idx, &reloc->rel)) {
+			WARN_ELF("gelf_update_rel");
+			return -1;
+		}
 		idx++;
 	}
 
@@ -1033,7 +1036,10 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 		reloc->rela.r_offset = reloc->offset;
 		reloc->rela.r_addend = reloc->addend;
 		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		gelf_update_rela(sec->data, idx, &reloc->rela);
+		if (!gelf_update_rela(sec->data, idx, &reloc->rela)) {
+			WARN_ELF("gelf_update_rela");
+			return -1;
+		}
 		idx++;
 	}
 
