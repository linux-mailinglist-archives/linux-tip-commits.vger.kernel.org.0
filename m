Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1635A3A6796
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jun 2021 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhFNNVc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Jun 2021 09:21:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFNNVc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Jun 2021 09:21:32 -0400
Date:   Mon, 14 Jun 2021 13:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623676768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5q9+MaoHfV/mDKcaDuJodpqNRdwr+f/ZC3PEstNU0p8=;
        b=1xkAbuHASmPAdqUvn4g0Eh6r3Nl1PpG5SGl8DPSscie1CSriIbf6C3SwXKpt8oVoc2RyKm
        KZRn9VKfAUKGTz+f9sTKj31/aXbEG8HTGxXFoE8fIpPfL6DtXYH3rHk+TalRddj6KScVhn
        6e9n0dhAZ1OZ2VxvFpFd2hlOecxqlrfuLYngntW62CINu695tpOuHcWsE7jrzAz7Ybg78f
        wdSgASCSwp5ofUYMxxwMFVyXHdpy6zPhuh/SliEc0Cs6P5Rngy6WLN/Sfwz0C3QyuFcYdx
        u3e93dOTEYJlcLf5gT3/pXKvO9dED4U9cm3dumIkTSUYYwbgg3ByTKaZ66p0mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623676768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5q9+MaoHfV/mDKcaDuJodpqNRdwr+f/ZC3PEstNU0p8=;
        b=WjTGenGbzUt7vZ0BaclYK7dg6cVjAYkRUKTSyu/M2b7oEWZKvwPctjA5PKB1Nf7sre9qbj
        Q9609hNk6hK5mUBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Improve reloc hash size guestimate
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
References: <YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162367676767.19906.18401009799732706895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d33b9035e14a35f6f2a5f067f0b156a93581811d
Gitweb:        https://git.kernel.org/tip/d33b9035e14a35f6f2a5f067f0b156a93581811d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 08:33:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jun 2021 14:05:36 +02:00

objtool: Improve reloc hash size guestimate

Nathan reported that LLVM ThinLTO builds have a performance regression
with commit 25cf0d8aa2a3 ("objtool: Rewrite hashtable sizing"). Sami
was quick to note that this is due to their use of -ffunction-sections.

As a result the .text section is small and basing the number of relocs
off of that no longer works. Instead have read_sections() compute the
sum of all SHF_EXECINSTR sections and use that.

Fixes: 25cf0d8aa2a3 ("objtool: Rewrite hashtable sizing")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Debugged-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lkml.kernel.org/r/YMJpGLuGNsGtA5JJ@hirez.programming.kicks-ass.net
---
 tools/objtool/elf.c                 | 11 ++++-------
 tools/objtool/include/objtool/elf.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a8a0ee2..2371ccc 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -288,6 +288,9 @@ static int read_sections(struct elf *elf)
 		}
 		sec->len = sec->sh.sh_size;
 
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
+			elf->text_size += sec->len;
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
@@ -581,13 +584,7 @@ static int read_relocs(struct elf *elf)
 	unsigned int symndx;
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
-	sec = find_section_by_name(elf, ".text");
-	if (!sec) {
-		WARN("no .text");
-		return -1;
-	}
-
-	if (!elf_alloc_hash(reloc, sec->len / 16))
+	if (!elf_alloc_hash(reloc, elf->text_size / 16))
 		return -1;
 
 	list_for_each_entry(sec, &elf->sections, list) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9008275..e343950 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -83,6 +83,7 @@ struct elf {
 	int fd;
 	bool changed;
 	char *name;
+	unsigned int text_size;
 	struct list_head sections;
 
 	int symbol_bits;
