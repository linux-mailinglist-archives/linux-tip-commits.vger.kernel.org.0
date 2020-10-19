Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA99292EB5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgJSTph (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 15:45:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbgJSTp1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 15:45:27 -0400
Date:   Mon, 19 Oct 2020 19:44:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603136685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YcgJ4BPdlQmnU2PeWPhz9B/1NJuC8LEYYfO6G2QaXrE=;
        b=O1y9/IfctEZpD9bngO5Xg1GNjZKS3rlkS/XjqZLVsBhNSYf6L3R+C87mNZt5Ej+jAMK933
        Aobry+GNVJ5yHaXBj0UeLHGtr2axfhdJDeAQ3hYnEau1x7AGIvzFkeepDF7KAaz7SIjsYK
        iJW9v2qcJhIQlr4l/Wrps3Ssmv/Y/xKvEsRLeMMzZI0jhkwYQ+D8Lq6HQdha5gTi4tJk3s
        UU7R3MFO0sB8D1RKx9pVcIi9dqG2STS3fs4lXXyqyeRAg7lukbt0j/gYgO9vNeKhWrSEaY
        3g8kNmxBQiRLy4rfHT3oUGMVOnljuDAnsB87xC8PqtHtEU9XxeQAce/SxkKb4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603136685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YcgJ4BPdlQmnU2PeWPhz9B/1NJuC8LEYYfO6G2QaXrE=;
        b=PdNK/zck0y54oBXfLAGcB66GzQVhxoUQDc0d/FlBG9bSAKTDJo0gW4Ltb59f1wIoj5cVEQ
        7pOb2hCJHhfdTaCQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Disable stack protection for head$(BITS).o
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201008191623.2881677-6-nivedita@alum.mit.edu>
References: <20201008191623.2881677-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160313668451.7002.5512333485207413562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     103a4908ad4da9decdf9bc7216ec5a4861edf703
Gitweb:        https://git.kernel.org/tip/103a4908ad4da9decdf9bc7216ec5a4861edf703
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 08 Oct 2020 15:16:23 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 19 Oct 2020 13:11:00 +02:00

x86/head/64: Disable stack protection for head$(BITS).o

On 64-bit, the startup_64_setup_env() function added in

  866b556efa12 ("x86/head/64: Install startup GDT")

has stack protection enabled because of set_bringup_idt_handler().
This happens when CONFIG_STACKPROTECTOR_STRONG is enabled. It
also currently needs CONFIG_AMD_MEM_ENCRYPT enabled because then
set_bringup_idt_handler() is not an empty stub but that might change in
the future, when the other vendor adds their similar technology.

At this point, %gs is not yet initialized, and this doesn't cause a
crash only because the #PF handler from the decompressor stub is still
installed and handles the page fault.

Disable stack protection for the whole file, and do it on 32-bit as
well to avoid surprises.

 [ bp: Extend commit message with the exact explanation how it happens. ]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20201008191623.2881677-6-nivedita@alum.mit.edu
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 04ceea8..68608bd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -47,6 +47,8 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
+CFLAGS_head$(BITS).o	+= -fno-stack-protector
+
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
