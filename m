Return-Path: <linux-tip-commits+bounces-1912-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CB9458C2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E411F232F1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749F1C2303;
	Fri,  2 Aug 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRJNIYqV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQGHQUqy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB71C0DC1;
	Fri,  2 Aug 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583731; cv=none; b=MyQ++jPfdOfxCwu6nrTyf7fKsP4Btqdr2z4bv+LvrGIOhERy8ODj7n04WMW3ItJbn4kvQsPoTyymAZFVvMFXvIpT0nvjU1GOd8Cq6GCKEOO/UcOiRu7E+qLQ+2HrH3cdw6Onj6IlM6N1Kc0LtEX8QSGPJzP/Rp4/tQLB2sHLYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583731; c=relaxed/simple;
	bh=eSVR0ivgMb2rD2JV7JSP6Z32YgRncPjqKaeBVgh8QZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IhR0i1d1ofdFJCbWL7nUL0fxYA1e+nfyjQgmY1ps/IqB5ftybQsTJ3Q8SuKiecJKtzpRLEV5KGFGE8ZhrpRyHey9S+t1SCHURFzE+KO/5gQ9888wplTLjlJzXT5k1pNpSlANlLXXQBAQI7cGX7b24BubDAhLmkaXH73JU7b3bJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRJNIYqV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQGHQUqy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QOjRKKDXXdDXcD/8SkufvHMQ7lD2Bf/QGt2BxTDeh8=;
	b=zRJNIYqVbHAYwo1W2YfKf1UqMW8BMFTyqFfHrthtwdMIzKH9UFxMIaz+bhGPNzOxHAvj4S
	pnY2SnTsxWgLZveHBOf+PxVIPHX+OrKWUO90wPQ0upCYrMfaLYXcl0xm3HV9r4EQBtzX8W
	EWbXhkuTZwNPI95wA1i2GNaaYiN//37tObu2E8f9drQoLqWZCrWaaVtuBfXFiMKOxSq/Ou
	+7STQHDd7LWV1u5my+ZqRxYmz9DWfehYscBthyP8WNDeVLLxEGB/LTS3BQ/kBEre60FAyJ
	dC+maLGvejh8yM/QtXYfqKvCzTNq5S0VFia1aB3S/YBK6/aZdDD3uF8n8TfNSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QOjRKKDXXdDXcD/8SkufvHMQ7lD2Bf/QGt2BxTDeh8=;
	b=XQGHQUqy6cTeI2hu95qTsozHhfm7UoatmATCPM7ViyS/PIpBL1EtNk2iegJ0MdH717G+UA
	I1eNgo385npdPoCg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Remove unused variable
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-2-darwi@linutronix.de>
References: <20240718134755.378115-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372626.2215.9009669202769080316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     39e470057f785eab7b6638feb3f24cbad6816aff
Gitweb:        https://git.kernel.org/tip/39e470057f785eab7b6638feb3f24cbad6816aff
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:18 +02:00

tools/x86/kcpuid: Remove unused variable

Global variable "num_leafs" is set in multiple places but is never read
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-2-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 24b7d01..e1973d8 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -76,7 +76,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static int num_leafs;
 static bool is_amd;
 static bool show_details;
 static bool show_raw;
@@ -246,7 +245,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
 		if (allzero)
 			continue;
-		num_leafs++;
 
 		if (!has_subleafs(f))
 			continue;
@@ -272,7 +270,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 						eax, ebx, ecx, edx);
 			if (allzero)
 				continue;
-			num_leafs++;
 		}
 
 	}

