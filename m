Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D83B22F8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFWWLS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFWWLQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:16 -0400
Date:   Wed, 23 Jun 2021 22:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xo5YQM3aed8x11ng86RyC9XsDQKlfzDx6gojviv9vTY=;
        b=Hr/A7WmHB0rba/x4M9ZN+MeP9AZ9URxIZ29P6OQ/DdobCiMasNo2T0Cv/sfAlopjkT6h5F
        KRZVMzlu6VSwXs6tyEMGU9gQ5RnxK8/mXxJ35XfH5Pb53TNF29mZvb6PhD2hg5S5dnikYe
        EuIpfJ/VYJp6AbLWOJkwA63pa17bdE8EwaD8gouIEJSQ8sOiwFxkH2ptU43r94k/hw8ySz
        OaxbJOo1MXKPprc4Q93t0eg/9/pBtWQOQDoOBLK2japNnaVp3ED3WBLB9Az2bXVdbpZ3yG
        99HK5EJA3ukGOzhSMqvs92e7fv/GQ2YzCmHkH4LctNO4z87GutyTQM4f5WMG5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xo5YQM3aed8x11ng86RyC9XsDQKlfzDx6gojviv9vTY=;
        b=NiQDpyaCLSPcsiwXOnSzqV7mbEUSZy/0OMS2an1A6sGLt+SKJraKGr3328lxUKaK10I6DD
        fVjnSNVxMppHpDDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Mark init_fpstate __ro_after_init
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.992342060@linutronix.de>
References: <20210623121456.992342060@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613564.395.4246154051266428799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     bf68a7d98922e1665019b8bf0c4791500837c857
Gitweb:        https://git.kernel.org/tip/bf68a7d98922e1665019b8bf0c4791500837c857
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:24 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:58:45 +02:00

x86/fpu: Mark init_fpstate __ro_after_init

Nothing has to write into that state after init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.992342060@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 5295cba..7ada7bd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -23,7 +23,7 @@
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
-union fpregs_state init_fpstate __read_mostly;
+union fpregs_state init_fpstate __ro_after_init;
 
 /*
  * Track whether the kernel is using the FPU state
