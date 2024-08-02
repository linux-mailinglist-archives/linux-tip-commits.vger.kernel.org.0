Return-Path: <linux-tip-commits+bounces-1913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1579458C3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FD228384F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BB1C2305;
	Fri,  2 Aug 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="am6yxIWw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzOIN6wE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71891BF33B;
	Fri,  2 Aug 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583731; cv=none; b=dfQ1Fq1T5+8I1Whitt9GfnMRfz5wrAeSVX/L7Pc5zH+RZF4/wJpbPaCvitWLZANGloxaOBqzCTNUF8pcakoFGp1moZbpMdfaUIcqMU0wTkTbEi3jC85kPJSctFMDkav7KK8LaF2H48VpIL95CATtuyVhJn+OttsS4ZxWkP+iYz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583731; c=relaxed/simple;
	bh=qM53wPbgXC8+fB7/f4ReGLUtVtUY7x0jmC1ovuPPUpM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kOAj7IjEKr1MlGZ7P1fpvyGfY6A8pM9rohfyS37zhdl2ouxKtbM5DBK8XMZ4xdtIO+lGvj6VRlAuN6x1pvKXVQmlhP+2NLLPdY30XuhAYbi7SjCNDJmUF5+NM6IjjZfpB8o6VnyPVydyQE5/4VHum+NPJBrxcCqQBl/q8MonUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=am6yxIWw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzOIN6wE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW53Ok1izKf+1IYeoqZ/H0DZALyLvDBtlkpkAFrWvc0=;
	b=am6yxIWwp0YSaQvPTbERP55EVmZHKGBqCWhmfML0tTgjrO1wQ36Q9sjd81zSTeE498x+6n
	Viftn9bNRtm6BsyQIR3MYNQrQdUh5z74Rz17sOEl2YBBL8h+OSbhcPwFlmDDh80x8cKBxe
	nA/OFFfFMH53ROalQfmNJ0LeW/KgjG+c/RgRSq2S6iXTBK5WMFf8E02YCrckTvCG3PfJap
	ANvEnAhce/H0oLlSTbls8UrMXGQZ3rJ1A9dybo0auVzl8oCtIvPHEACaDqxvcidJBwAKl+
	n0rZIvdFgrYNQaMSVZFyPM//3xyMdi33Z/3gvV+uyVsR1UGRo+8C8Z9PmKjVhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583726;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW53Ok1izKf+1IYeoqZ/H0DZALyLvDBtlkpkAFrWvc0=;
	b=EzOIN6wEwZ+PEhQCcD/IqFwAdoyjdK1x2o1gP8ovdhlfvrqYUkMjYfPRPEPQrvjb2NF7Vl
	cVuw0zbMNBczchBg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] tools/x86/kcpuid: Set max possible subleaves count to 64
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-4-darwi@linutronix.de>
References: <20240718134755.378115-4-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372574.2215.15209171329256529065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     5dd7ca42475bb15fd93d58d42e925512776f14a4
Gitweb:        https://git.kernel.org/tip/5dd7ca42475bb15fd93d58d42e925512776f14a4
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:18 +02:00

tools/x86/kcpuid: Set max possible subleaves count to 64

cpuid.csv will be extended in further commits with all-publicly-known
CPUID leaves and bitfields.  One of the new leaves is 0xd for extended
CPU state enumeration.  Depending on XCR0 dword bits, it can export up to
64 subleaves.

Set kcpuid.c MAX_SUBLEAF_NUM to 64.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-4-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 08f64d9..a87cddc 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -203,7 +203,7 @@ static void raw_dump_range(struct cpuid_range *range)
 	}
 }
 
-#define MAX_SUBLEAF_NUM		32
+#define MAX_SUBLEAF_NUM		64
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
 	u32 max_func, idx_func;

