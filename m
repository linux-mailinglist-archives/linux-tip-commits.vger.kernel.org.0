Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789EB281091
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Oct 2020 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgJBK0s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Oct 2020 06:26:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41784 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJBK0s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Oct 2020 06:26:48 -0400
Date:   Fri, 02 Oct 2020 10:26:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601634406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmBj6GSCyLU6QAhvQ1UXh5qEoCfQao6uYrskWW0TjVE=;
        b=AEWI4qclL7huy9Y9nhgJiq781S0YX9FQLbUCRZWlEr2uZ5/8wmBGOyFRbYBs1qSV1KEwAg
        KGaIB8onlJUbhRwUokjioD7VcVs5JN765j2epXvamnT5IHMa38+rG0veFTsQTMdxExkZza
        lw4yoyxOkJlHst+JPL3BkuvcPRuLsUAy12WMh0fkcaPYHDvQuHYaL0Gai3ry3IL3zeIDHy
        hgmHxsYYgBqGpiDJVmFZsTlTNntZWfnwHn8TmnysyVl5hIAp76BiQhTfZ+skpA0veDtfmZ
        HDYjF3WPzlv2QWlzD0Ln/o8cjkEWn2YZLZk5W/xtktjIJs+DiAITUxXblpnz1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601634406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmBj6GSCyLU6QAhvQ1UXh5qEoCfQao6uYrskWW0TjVE=;
        b=Bo7AY6+o+VTbq8wrAIN5WNKevHkrDSo7XQEWdcuVgUUmq3ujREQmwRbQhNG5FjmOSv9nCx
        ej+Ba+3MchUzGHAA==
From:   "tip-bot2 for Mark Mossberg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/dumpstack: Fix misleading instruction pointer
 error message
Cc:     Mark Mossberg <mark.mossberg@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201002042915.403558-1-mark.mossberg@gmail.com>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
MIME-Version: 1.0
Message-ID: <160163440548.7002.940529565709906799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     238c91115cd05c71447ea071624a4c9fe661f970
Gitweb:        https://git.kernel.org/tip/238c91115cd05c71447ea071624a4c9fe661f970
Author:        Mark Mossberg <mark.mossberg@gmail.com>
AuthorDate:    Fri, 02 Oct 2020 04:29:16 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 02 Oct 2020 11:33:55 +02:00

x86/dumpstack: Fix misleading instruction pointer error message

Printing "Bad RIP value" if copy_code() fails can be misleading for
userspace pointers, since copy_code() can fail if the instruction
pointer is valid but the code is paged out. This is because copy_code()
calls copy_from_user_nmi() for userspace pointers, which disables page
fault handling.

This is reproducible in OOM situations, where it's plausible that the
code may be reclaimed in the time between entry into the kernel and when
this message is printed. This leaves a misleading log in dmesg that
suggests instruction pointer corruption has occurred, which may alarm
users.

Change the message to state the error condition more precisely.

 [ bp: Massage a bit. ]

Signed-off-by: Mark Mossberg <mark.mossberg@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201002042915.403558-1-mark.mossberg@gmail.com
---
 arch/x86/kernel/dumpstack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 48ce445..ea8d51e 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -115,7 +115,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 
 	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
-		printk("%sCode: Bad RIP value.\n", loglvl);
+		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		       loglvl, prologue);
 	} else {
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
 		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
