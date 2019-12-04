Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90465112516
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2019 09:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLDIdw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 Dec 2019 03:33:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56382 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIdv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6M-0005K9-VG; Wed, 04 Dec 2019 09:33:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9340B1C2657;
        Wed,  4 Dec 2019 09:33:36 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternative: Remove text_poke_loc::len
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132457.989922744@infradead.org>
References: <20191111132457.989922744@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841650.21853.14292516251791233865.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     97e6c977ccf128c3f34d6084ad53fc0021f90e03
Gitweb:        https://git.kernel.org/tip/97e6c977ccf128c3f34d6084ad53fc0021f90e03
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 12:44:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/alternative: Remove text_poke_loc::len

Per the BUG_ON(len != insn.length) in text_poke_loc_init(), tp->len
must indeed be the same as text_opcode_size(tp->opcode). Use this to
remove this field from the structure.

Sadly, due to 8 byte alignment, this only increases the structure
padding.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.989922744@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cfcfadf..6e3ee73 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -938,7 +938,6 @@ static void do_sync_core(void *info)
 
 struct text_poke_loc {
 	void *addr;
-	int len;
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
@@ -965,6 +964,7 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_loc *tp;
 	void *ip;
+	int len;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
@@ -1004,7 +1004,8 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 			return 0;
 	}
 
-	ip += tp->len;
+	len = text_opcode_size(tp->opcode);
+	ip += len;
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
@@ -1085,10 +1086,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		if (tp[i].len - sizeof(int3) > 0) {
+		int len = text_opcode_size(tp[i].opcode);
+
+		if (len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
 				  (const char *)tp[i].text + sizeof(int3),
-				  tp[i].len - sizeof(int3));
+				  len - sizeof(int3));
 			do_sync++;
 		}
 	}
@@ -1141,7 +1144,6 @@ void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	BUG_ON(len != insn.length);
 
 	tp->addr = addr;
-	tp->len = len;
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {
