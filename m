Return-Path: <linux-tip-commits+bounces-3599-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41322A40824
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264D27ABBE7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A320B1F9;
	Sat, 22 Feb 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WrIbJxw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zOCdvX5a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2720A5F2;
	Sat, 22 Feb 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225388; cv=none; b=pb2irScP9C+G1WRFTgdJTxKrb0R769mEn0bNn6PtIWh7Z85AcycirGbrI7tC2n/UqUgKuKHIRgzL5YsAsPbg6zUvPNKfWgC6xe/dFVrdtYC10xsh3DvJ/BQFRDdkR2ycyRv+MDxeAL4yc0bN18/Hxplh3+SNU+PnSDZxbA+ihxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225388; c=relaxed/simple;
	bh=UESG95FDx65TuZvSWYrI+yhv8XOdxQgxVUY483SMbjA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HeNvMoQ3eCjkepBs0KW4/qSTZd5kPSnuafUVgb4OVhl3Ix/DiBqONXgM97a8/Em2W0b/qCD3KnochXe1IAP4IigLmFLuOQj8I1malZW2CEbdYNFXMF090EnDnDQFDwFiMitw8YgOqNTZ3J33Pwq3XTjDEvCtaL2yGWwyXVUc9Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WrIbJxw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zOCdvX5a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 11:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740225385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdxgI3hX0qF+ovfNe78Q+rFntWDm1RTLrSH3ZzCgb1w=;
	b=3WrIbJxwiTgeD96wTckylalxxpnxL6VIdSgcCKzN4Nf1a/XsONXIzGlumI934FtyYagXM1
	LVbF0b8b2G7qyyMFjo2e18/PJk6aA/juyCQN8yCVaS1kOdlSkrPtS+jkcV6VU4yDgQGNvJ
	mx90GeKUVDnkaUyziObFBE0/HSnbwpY674ArLFSLbRJvQbmhoUuOhCgRV4mwJJwoRN99vn
	wTmrrrc8uw2HlmcSIgpAt4iGxYWnMYEfUEr2OOczlONWdEe4yUxbrkJW2/JC9ta9OV4EHN
	S4s5anoGuBc1vtTR9QY3kXq+y+LI9g2S0O1xsYMXHgKG8eOG/9rHRX2r02kAsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740225385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdxgI3hX0qF+ovfNe78Q+rFntWDm1RTLrSH3ZzCgb1w=;
	b=zOCdvX5a6R4XslzIfeG6EuMzQAXKO43rAu4zosJB/EpjGlWLMPoMmwicHUKfNARyHke81f
	zEPs+HZ+6EY0yjAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Update Intel Family comments
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250127162252.GK16742@noisy.programming.kicks-ass.net>
References: <20250127162252.GK16742@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022538482.10177.9092274090971595395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     43bb700cff6bc2f0d337006b864192227fb05dc1
Gitweb:        https://git.kernel.org/tip/43bb700cff6bc2f0d337006b864192227fb05dc1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 27 Jan 2025 17:22:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 12:50:18 +01:00

x86/cpu: Update Intel Family comments

Because who can ever remember all these names.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250127162252.GK16742@noisy.programming.kicks-ass.net
---
 arch/x86/include/asm/intel-family.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 8359113..f9f67af 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -110,9 +110,9 @@
 
 #define INTEL_SAPPHIRERAPIDS_X		IFM(6, 0x8F) /* Golden Cove */
 
-#define INTEL_EMERALDRAPIDS_X		IFM(6, 0xCF)
+#define INTEL_EMERALDRAPIDS_X		IFM(6, 0xCF) /* Raptor Cove */
 
-#define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD)
+#define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD) /* Redwood Cove */
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
 /* "Hybrid" Processors (P-Core/E-Core) */
@@ -126,16 +126,16 @@
 #define INTEL_RAPTORLAKE_P		IFM(6, 0xBA)
 #define INTEL_RAPTORLAKE_S		IFM(6, 0xBF)
 
-#define INTEL_METEORLAKE		IFM(6, 0xAC)
+#define INTEL_METEORLAKE		IFM(6, 0xAC) /* Redwood Cove / Crestmont */
 #define INTEL_METEORLAKE_L		IFM(6, 0xAA)
 
-#define INTEL_ARROWLAKE_H		IFM(6, 0xC5)
+#define INTEL_ARROWLAKE_H		IFM(6, 0xC5) /* Lion Cove / Skymont */
 #define INTEL_ARROWLAKE			IFM(6, 0xC6)
 #define INTEL_ARROWLAKE_U		IFM(6, 0xB5)
 
-#define INTEL_LUNARLAKE_M		IFM(6, 0xBD)
+#define INTEL_LUNARLAKE_M		IFM(6, 0xBD) /* Lion Cove / Skymont */
 
-#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC)
+#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC) /* Cougar Cove / Crestmont */
 
 /* "Small Core" Processors (Atom/E-Core) */
 

