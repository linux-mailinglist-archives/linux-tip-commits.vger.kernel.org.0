Return-Path: <linux-tip-commits+bounces-4980-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15505A88782
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023E73AE1B7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE432129A78;
	Mon, 14 Apr 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G65MpwbI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6nA/jkv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A1274641;
	Mon, 14 Apr 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644983; cv=none; b=n2vCOgx2RnSFTAnF97k9fqpS3pDgJKLnC/mjMwLufW3Czt3e9vWJub+sK8ncZckjg/VJNkjlffFht3jtsm8/nDVZqIdVFsYsijAj8/ZYVSMRFd03JEer7/JjvvwiB7xP2fbtXKsWea6GodUD3Pb39tjm7UoM9Ffg40T3U2NSgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644983; c=relaxed/simple;
	bh=pSe1a/5w5YFGWFBSIQgUt47dc05tpAipm/dfn4X1bzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gWkxPHnCmTmmpJNNGueoJu5prCJHP3AnWCMIsNFdtuKyondISyz9VYFCCzZp/wNncwX1nlS0tCAlguTmstlihkBNSAXOqvJ4/JGpDwNVj9ktSwwqeBdJnbEsndCvQzprc3ddTuoY4xqtf2xg289y1YRQXdG/AezpIs7qLzVV8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G65MpwbI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6nA/jkv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 15:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744644980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vsv2zN6FvKvtYohkvETjx/9zDLPOYPPhbrYicf37NP0=;
	b=G65MpwbIL1P2e0/DEFxYlzB4P0MnkPxCIhEjKqxX7EkSvqTCkgY5KDOvPHy9H1ekQAttzN
	sawiVlrlltKEUYBbtJ0vtz/wY23UA3ccgKrf1gRvepL7l33i8o5xKLNf29xe4dIsU02cuT
	wNOUep+zmaeb1dVZgbG+IMiniwRdTQfyLbj8WaJeviPx6eVE5fmcGbQUoL1hnEhJd2r17a
	xU/7EQZjYhdedMZjQPDjmT2s+lJs9BP3yo6P3oOAYmDZZhnINP+WNy8VBboX2qEwHOdYK4
	5NxigaCw3fNYqphNM6Vcl+RXmWW9wMbOnxLkBLKm2QUN5Cr82uXpiInFgBt1kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744644980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vsv2zN6FvKvtYohkvETjx/9zDLPOYPPhbrYicf37NP0=;
	b=F6nA/jkv9krBFBydmD2pXz7xmka6+28hA4IxSvqLQVBHrQrPUqkxoQKKEzQBcHqOsRHH0b
	FN2hhnze2zj+CRCQ==
From: "tip-bot2 for Pi Xiange" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add CPU model number for Bartlett Lake
 CPUs with Raptor Cove cores
Cc: Pi Xiange <xiange.pi@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Christian Ludloff <ludloff@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Tony Luck <tony.luck@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414032839.5368-1-xiange.pi@intel.com>
References: <20250414032839.5368-1-xiange.pi@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174464497802.31282.8938459942122265802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     45842b59ec93a5c8f24b4e62f3a5759d3857c08e
Gitweb:        https://git.kernel.org/tip/45842b59ec93a5c8f24b4e62f3a5759d3857c08e
Author:        Pi Xiange <xiange.pi@intel.com>
AuthorDate:    Mon, 14 Apr 2025 11:28:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 17:19:30 +02:00

x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores

Bartlett Lake has a P-core only product with Raptor Cove.

[ mingo: Switch around the define as pointed out by Christian Ludloff:
         Ratpr Cove is the core, Bartlett Lake is the product.

Signed-off-by: Pi Xiange <xiange.pi@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Christian Ludloff <ludloff@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250414032839.5368-1-xiange.pi@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 3a97a7e..be10c18 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -126,6 +126,8 @@
 #define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD) /* Redwood Cove */
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
+#define INTEL_BARTLETTLAKE		IFM(6, 0xD7) /* Raptor Cove */
+
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_LAKEFIELD			IFM(6, 0x8A) /* Sunny Cove / Tremont */

