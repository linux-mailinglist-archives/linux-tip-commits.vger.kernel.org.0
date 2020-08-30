Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8EA25702F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 30 Aug 2020 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgH3TkR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 30 Aug 2020 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgH3TkP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 30 Aug 2020 15:40:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93BC061573;
        Sun, 30 Aug 2020 12:40:14 -0700 (PDT)
Date:   Sun, 30 Aug 2020 19:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598816412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+QkKGJqi66MJvVsgqogvBcjvDMtj7fL4LKp25gqKqU=;
        b=z319s3C2oq2y18ZxGXttdkUKyXeRiIcbkJ/tcSCcBuymOWY2NgRLpAcR3ZkeTIKjYoMMp4
        hw3Gnt+O8pcuJK8oRSsGRw/PKgwtSFv6h+5BLtq0Aa54+x3HNLmuU/bBderY0cFNb7zO4R
        09yElgtOi3eH8b+Tna+AEziuwoZ3jiHjaHX7UXK9NWW787ZibPOtAGMwAbiU/MT39YhERd
        qdAs8WWeVOBW+KyFBoRBIUNqjwnu5RYaj8xurxIljuwoNv50tUEATk8FRj5uPDCXF1A2Zb
        ayfPAAJfXJTNU/NwaLBOC/J9D01yk4SSax6TcBdR3xVMS8ZFzjQ3PD9vJBCTYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598816412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+QkKGJqi66MJvVsgqogvBcjvDMtj7fL4LKp25gqKqU=;
        b=Tgq1aTVk4135cAgihD9ASk4JZuVsSjtUdxzEl+Pj22b14lQ+ebvai567WZkhZsSGTyn5zx
        w2OxFf+UeFk/pvDA==
From:   "tip-bot2 for Kyung Min Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Enumerate TSX suspend load address
 tracking instructions
Cc:     Kyung Min Park <kyung.min.park@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1598316478-23337-2-git-send-email-cathy.zhang@intel.com>
References: <1598316478-23337-2-git-send-email-cathy.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <159881641150.20229.2207709091919187438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     18ec63faefb3fd311822556cd9b949f66b1eecee
Gitweb:        https://git.kernel.org/tip/18ec63faefb3fd311822556cd9b949f66b1eecee
Author:        Kyung Min Park <kyung.min.park@intel.com>
AuthorDate:    Tue, 25 Aug 2020 08:47:57 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 30 Aug 2020 17:43:40 +02:00

x86/cpufeatures: Enumerate TSX suspend load address tracking instructions

Intel TSX suspend load tracking instructions aim to give a way to choose
which memory accesses do not need to be tracked in the TSX read set. Add
TSX suspend load tracking CPUID feature flag TSXLDTRK for enumeration.

A processor supports Intel TSX suspend load address tracking if
CPUID.0x07.0x0:EDX[16] is present. Two instructions XSUSLDTRK, XRESLDTRK
are available when this feature is present.

The CPU feature flag is shown as "tsxldtrk" in /proc/cpuinfo.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1598316478-23337-2-git-send-email-cathy.zhang@intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 2901d5d..83fc9d3 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -368,6 +368,7 @@
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
+#define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
