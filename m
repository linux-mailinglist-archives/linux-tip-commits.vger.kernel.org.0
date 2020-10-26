Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED371298D36
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775675AbgJZMwl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775643AbgJZMwj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:39 -0400
Date:   Mon, 26 Oct 2020 12:52:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716757;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILQPtPU4iWvoqSRttb106bkOKp5DhQS8MKf6uxdvhCU=;
        b=kAt5RoXB2HLA7w3Qp4SgMfYfurK+IYZbkIXWQhz1/KjujpOg8b84xvpSIlUaUO/KiV12TG
        +0X9uNZnmdUvWLboS5DP5+dh99iP/OfRzGNh6oOZqdBoNFIccXM6qGdAVS1IpMor/eTLK6
        DKM92Y/sNCz56yAf6TAsvPl/93F7sdtRfYjmxgn2o4p1SvDXBl0Ja4UasmyHf/eFP6XTcu
        u57vSZNWZ3CuNcpiwrvFps82whtXPvt7jv0204Bq1hda5pVFkh76fDOjxzL9ByffId9t5U
        v4Q0j2Y5RVGMRyqWREBctUoJbMw9CxOF8LWaY2/xD+sQl8guPznk77QiJ6dB5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716757;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILQPtPU4iWvoqSRttb106bkOKp5DhQS8MKf6uxdvhCU=;
        b=4YKgeADVOvOjaFBp1ed5dyYYx+Fxm9X6l1xS8QbbigvS4Djcm8POf6KWXWuA5eWHO9eAce
        uJSdqs/Kx2ndG5Cw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/oprofile: Avoid TIF_IA32 when checking 64bit mode
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-4-krisman@collabora.com>
References: <20201004032536.1229030-4-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675663.397.11073210370521166662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     47cd4dac1fb21759ffcfe0600827c87fa6acdfa7
Gitweb:        https://git.kernel.org/tip/47cd4dac1fb21759ffcfe0600827c87fa6acdfa7
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:29 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:46 +01:00

x86/oprofile: Avoid TIF_IA32 when checking 64bit mode

In preparation to remove TIF_IA32, stop using it in oprofile code. Use
user_64bit_mode() instead.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201004032536.1229030-4-krisman@collabora.com

---
 arch/x86/oprofile/backtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/oprofile/backtrace.c b/arch/x86/oprofile/backtrace.c
index a2488b6..1d8391f 100644
--- a/arch/x86/oprofile/backtrace.c
+++ b/arch/x86/oprofile/backtrace.c
@@ -49,7 +49,7 @@ x86_backtrace_32(struct pt_regs * const regs, unsigned int depth)
 	struct stack_frame_ia32 *head;
 
 	/* User process is IA32 */
-	if (!current || !test_thread_flag(TIF_IA32))
+	if (!current || user_64bit_mode(regs))
 		return 0;
 
 	head = (struct stack_frame_ia32 *) regs->bp;
