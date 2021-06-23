Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3DE3B22F5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFWWLR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWWLO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:14 -0400
Date:   Wed, 23 Jun 2021 22:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGg3N+1XfAz5kxmi1YmiZGGONBO0ytCgg56d89MUpug=;
        b=AqbqUgtzkRt17yPksMMrMi7BE9v/QrvSlacRMhCIjcwJNi8ldAZC9y2rwg+VwNhOoR5Tsl
        UQPqNIOjiQDJzgRY7hTaSGiQHdu6QflnI4T7bb9mi/30B/XKq9clEkkkxVilEIC70+zCri
        6OiTOecybXKMcpNuuRpMjaDyrRm6yQrTYwi9n0cIpbRimrP5qcqAVRl0N2gmdokrR1yQEW
        2ryW0GfnKDXYF36CqFDlQuA+nZD6Qk/g2BxNb3pSNCvi4zrDRy2fpUaAu8e28EoRzu6MbM
        fIf1o8lC5n5cGx12BkxW9u8mCFn50d0YVktbkKdpZLPbgMQqyNAMmWvn4Dq6Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGg3N+1XfAz5kxmi1YmiZGGONBO0ytCgg56d89MUpug=;
        b=VzqERC+afwVfGqZSieQBgh8jc8ns3HGv/yEH5PmSpKgmrEl0G7TRi7HW0gV4TEp7hmhlaq
        7fV7x8Eivbt3dHAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Remove the legacy alignment check
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.184149902@linutronix.de>
References: <20210623121457.184149902@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613390.395.18150299362946531043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9ba589f9cdbd8906465b108bc7ec0fc1519a06d3
Gitweb:        https://git.kernel.org/tip/9ba589f9cdbd8906465b108bc7ec0fc1519a06d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 20:01:55 +02:00

x86/fpu/signal: Remove the legacy alignment check

Checking for the XSTATE buffer being 64-byte aligned, and if not,
deciding just to restore the FXSR state is daft.

If user space provides an unaligned math frame and has the extended state
magic set in the FX software reserved bytes, then it really can keep the
pieces.

If the frame is unaligned and the FX software magic is not set, then
fx_only is already set and the restore will use fxrstor.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.184149902@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 42e85c3..8a327c0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -306,9 +306,6 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		}
 	}
 
-	if ((unsigned long)buf_fx % 64)
-		fx_only = 1;
-
 	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
