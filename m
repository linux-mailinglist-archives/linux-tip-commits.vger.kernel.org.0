Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D661928D33B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Oct 2020 19:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgJMRl0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 13 Oct 2020 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMRlZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 13 Oct 2020 13:41:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42617C0613D0;
        Tue, 13 Oct 2020 10:41:25 -0700 (PDT)
Date:   Tue, 13 Oct 2020 17:41:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602610880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nz8S0QJntGZrjmA1YVrBL07KP5xJTEQ9dbpbyuq5xS4=;
        b=hq00tO2undWg1x5z8kJ31pN0vELKeaqzAXqahAoZA46TxhIcwMflpdbsxGpt08Z+nFFpYn
        dCVZSKus6JVUOkkiyeivrDJbmOGngJpA0YeNvJdbMYSYxcmTrHT/JIiKIQuquRFq9vLeXV
        GzbFYKvngs/kz584SFm4Xl08VoxyQfN775Q+vBSqgnrAV7+JHkRac0Ji0ApP19AbhFZmt6
        Qu/HSwnKAzAfgdUBg+jpB1wZjL0WaOZNLbJFuMsLNeUwJ6GI3M+KeC9fAVbY4tdI+IE/Iu
        EPmD3XcJi4PPIt/P3leHJ87oeCcPBojw786XQsKbJXbVFm/kNIUTwUDVNcpH1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602610880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nz8S0QJntGZrjmA1YVrBL07KP5xJTEQ9dbpbyuq5xS4=;
        b=xa366Fugi3Tdl2pDHkacvLml2N7pDEnrw5Gt6qJGLk39vA12CMmHdP6f5FWbaOP72GknPv
        xSh2B4/sWhlwigBQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Remove unused variable in UV5 NMI handler
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201013154731.132565-1-mike.travis@hpe.com>
References: <20201013154731.132565-1-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160261087913.7002.10262284099177006973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     081dd68c89061077930ec7776d98837cb64b0405
Gitweb:        https://git.kernel.org/tip/081dd68c89061077930ec7776d98837cb64b0405
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 13 Oct 2020 10:47:31 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 13 Oct 2020 19:21:13 +02:00

x86/platform/uv: Remove unused variable in UV5 NMI handler

Remove an unused variable.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201013154731.132565-1-mike.travis@hpe.com
---
 arch/x86/platform/uv/uv_nmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 0f5cbcf..eafc530 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -59,7 +59,6 @@ DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
 static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
 static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
-static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
 static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
 
 /* Non-zero indicates newer SMM NMI handler present */
@@ -247,7 +246,6 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
-		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
 		uvh_nmi_mmrx_type = "OCRD0-EXTIO_INT0";
 
 		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
@@ -258,7 +256,6 @@ static void uv_nmi_setup_mmrs(void)
 		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
 		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
 		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
-		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK;
 		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
 
 		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
