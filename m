Return-Path: <linux-tip-commits+bounces-3110-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2D9FBB75
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192E11885D12
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E81B4144;
	Tue, 24 Dec 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+HH6YrE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HDPq8OJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1171B4127;
	Tue, 24 Dec 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033614; cv=none; b=e/55wFLeEjCSUVN0k81kicIqEejxCBeDdq4dN3kuW9v1KvTwIBw9oS9KhtY+GI4NB1j1LbWr7voE2PYuj3YBjmw62mMBz5Zpo/q+piYQBKGeC30sKWX6GKMLxy8vZGjXjri1iuq3kdOeASYJ8Zzx+11DZu4psaGme89WymJUHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033614; c=relaxed/simple;
	bh=N/yocTapsvMpo29E27QPaMgSbRuRz4la9AXgm2aMK/4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HzNlknFJjbyuPJlf2BtUGtPq7lFntcQIM+dafBzl69UNZ1p5ioxKKSvanJL4VQFFe5WuKiO6C2LNldHtiSb/NmdpD18tRGBH9SL/0BV24N56lHGGwg8olfxrJbVINNWVvS8nfbs++44et+NwvWZ/T3hJqZP6Mj8BvTGKnY5mpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+HH6YrE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HDPq8OJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+U0NDNyisRIuBi50TtMwdHWIXDsGonU4mQgyOuf4GxM=;
	b=0+HH6YrEhHLsEUSSocFTZQzC1pdBae8ujYk93qVYK543+RuwV83n4eETbox28XO2phtCFT
	xAq1kkSc5Viqj1grYo+Plmudb1YlaD3sSLUv3EQ80gFi5Ls1yOCqODjUwxHA/V9M/VFVkz
	dQkkMtU+RD2+eYu/dH4eDS4tyT4hshQwBincHFaDoHgDaD5xfEHkFDYSoMaJM704+gKcch
	DWd55hKoHwfEsEQrAJccldTxV9KfTju8cMFXkKqq+4Uo1eEgSW68xh19G+HoTKm+Z2RIvV
	zLcZuAQfwBHcoAd0+sLfLzYcdbPUkqmhqRXi2dtyX20BGzSJZXo6D/bjdCrZqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+U0NDNyisRIuBi50TtMwdHWIXDsGonU4mQgyOuf4GxM=;
	b=0HDPq8OJnZI1A6N04+tM8pCrXp/9d6H2I4l/tfTynjU8RECKlS+Wy3UAVP5ahTpXk5kLOm
	68Q1JpHo5w42GqDg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/intel/uncore: Add Clearwater Forest support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241211161146.235253-1-kan.liang@linux.intel.com>
References: <20241211161146.235253-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503360470.399.16064335794412137814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b6ccddd6fe1fd49c7a82b6fbed01cccad21a29c7
Gitweb:        https://git.kernel.org/tip/b6ccddd6fe1fd49c7a82b6fbed01cccad21a29c7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 11 Dec 2024 08:11:46 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2024 17:47:23 +01:00

perf/x86/intel/uncore: Add Clearwater Forest support

>From the perspective of the uncore PMU, the Clearwater Forest is the
same as the previous Sierra Forest. The only difference is the event
list, which will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241211161146.235253-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d98fac5..e7aba73 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1910,6 +1910,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&gnr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);

