Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAF22D775
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jul 2020 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYMOq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jul 2020 08:14:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGYMOq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jul 2020 08:14:46 -0400
Date:   Sat, 25 Jul 2020 12:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595679283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWbLuEt0GcJJoCHotHJIuarMWHFXHOnLPSPfL0x79EU=;
        b=Z15MJQW3+LNXkevbMqW6ETf7Q7K8JYwEgNLP9KyuhcyQUdNIdMSGfJPClUYx2njiRH966w
        bWU6C+FWdiuU/SCSKNWxgv9g1Vuxrs2FY5dtC1rSrOGiYFoJuSXHD164POiAFdPheNbQN7
        04G5aGIPQw8YbNiP8Vodj6f3hMOWFVUdNmch8WEUi7p1DPKbWBGEb/LnfJfSdjzCAe/gl2
        jatrzWIJItwwKMPaNG0y1bMOaXSnCoaJbgcoF/rG29+VEcpnyIygPx9LeQb74qFHU/8spp
        gd9OMvwgO0WE1JvSlGdkuYV89ypn2oM0n4HnQLtS54qZkWSZ6ldrZSa6utFzxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595679283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWbLuEt0GcJJoCHotHJIuarMWHFXHOnLPSPfL0x79EU=;
        b=pMvrkJyga2TMB/YHbvagGNleWhyptSpGy4xeDSAySUikubRBxNyb0ENTo1DX5WZN03lz7N
        h80dcya2DcgrNiAw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add Lakefield, Alder Lake and Rocket Lake
 models to the to Intel CPU family
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721043749.31567-1-tony.luck@intel.com>
References: <20200721043749.31567-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <159567928234.4006.15571980059311082712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e00b62f0b06d0ae2b844049f216807617aff0cdb
Gitweb:        https://git.kernel.org/tip/e00b62f0b06d0ae2b844049f216807617aff0cdb
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 Jul 2020 21:37:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 12:16:59 +02:00

x86/cpu: Add Lakefield, Alder Lake and Rocket Lake models to the to Intel CPU family

Add three new Intel CPU models.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200721043749.31567-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index a338a6d..5e658ba 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -89,8 +89,15 @@
 #define INTEL_FAM6_COMETLAKE		0xA5
 #define INTEL_FAM6_COMETLAKE_L		0xA6
 
+#define INTEL_FAM6_ROCKETLAKE		0xA7
+
 #define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F
 
+/* Hybrid Core/Atom Processors */
+
+#define	INTEL_FAM6_LAKEFIELD		0x8A
+#define INTEL_FAM6_ALDERLAKE		0x97
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
