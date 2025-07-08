Return-Path: <linux-tip-commits+bounces-6028-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC82AFC7D1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6EA483B88
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C726E6E0;
	Tue,  8 Jul 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="274SAzPh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fgo98QNA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937026B76B;
	Tue,  8 Jul 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969045; cv=none; b=GFnJcaEudqbjQNFKOsEY3Z/DhwE2yMAK1vg+DKxPszSV68Ho6jLyXAqu/U9ZmUkcb8rcSojjFop8lzBPbd0vjg0ygVmRYmlyIyS9BfNWWae8Oxh3MJQbbUt2n1NaZLc5OxWW/KFaPAAElngYB3njfr2zSYBTEwO4EKcfu2Xooik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969045; c=relaxed/simple;
	bh=OYiPkfZhcA0jAyNUOwrdJGRuoNT2qYuLrVIKBRcLgyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=soyqGA09cBrCDHRLhrIFnNv4C+Cjn0zvte12C44OHwLnwni1D6csu+HxjiLLHtjbaGzaLAa7DKWZfLQdfQZYFAX4g0dHl7DzcpSvpryDko/nYFi7nQ2UQCdwWuQDN4MDg2AXf7JvDpKGxR7G28DERISKUIYqNIeYHu3c0Lf0Fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=274SAzPh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fgo98QNA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ALvPp76pFNfY+zyNi0uLb2s/oaupNu2LdNiy1WcdXk=;
	b=274SAzPhnuPgQPvcvVvfVxEpv/uPgbsq4xcIKX/fJ7ogrlQLFXsxsHOXPdxb3n6XOq4YgH
	BLEddLXlguDl/0L4rUMSyN+K02clMVONKHLfPx3LUcDQTMkI0I/RxV/q3cXNmJCmomrTWf
	hE989eEFTSatD70PO+XPuwWVbrRHMEgg6aaVO3j8kko3ZwSNpinw9NVVcjA/bS36ORUz50
	7sRqdvWzgvmoxLCKmfk9IL1pa2fp6RdxXqDxAvJpBASfglhkPOn3m6B+BY9SFcvhlHLCvh
	wvY6nYv7AgmnUs54aQjnwLf40gVETF72ov/82B7x4SOG1ZYTn2FCXez7s5QTug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ALvPp76pFNfY+zyNi0uLb2s/oaupNu2LdNiy1WcdXk=;
	b=Fgo98QNAV0gS0mMAon+uyRFkoOx4g7QrawQhCH7SUjUmsSAykEswoR1RJ5ZcObl8OJI4wA
	AI66AG2fjFqMwhDA==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] x86/msr-index: Add AMD workload classification MSRs
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-4-superm1@kernel.org>
References: <20250609200518.3616080-4-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196904073.406.7552423216674662645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     a3c4f3396b82849a04ffe12584c69d340f2b8610
Gitweb:        https://git.kernel.org/tip/a3c4f3396b82849a04ffe12584c69d340f2=
b8610
Author:        Perry Yuan <perry.yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:08 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 19:24:58 +02:00

x86/msr-index: Add AMD workload classification MSRs

Introduce new MSR registers for AMD hardware feedback support.  They provide
workload classification and configuration capabilities.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-4-superm1@kernel.org
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index b7dded3..4dbf6db 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -732,6 +732,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
=20
+/* AMD Hardware Feedback Support MSRs */
+#define MSR_AMD_WORKLOAD_CLASS_CONFIG		0xc0000500
+#define MSR_AMD_WORKLOAD_CLASS_ID		0xc0000501
+#define MSR_AMD_WORKLOAD_HRST			0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
=20

