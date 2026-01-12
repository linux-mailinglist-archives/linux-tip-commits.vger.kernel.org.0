Return-Path: <linux-tip-commits+bounces-7873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D324AD110A9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 510DE300DB20
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4C33E35A;
	Mon, 12 Jan 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHZyT+N4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhI1L3I1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AC33C1BE;
	Mon, 12 Jan 2026 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204989; cv=none; b=KXBhNxa9ykXG6lILqPE8Y8Ryc3CuRZwtFU7XZZj/WUS99Q0/5NCwPYA6o8GP3I/Mh8/5eo+Mi/aKn9UNyTd3sJHrqr3AuGHJ2kkJHsPN2oy1Th9JCkcQ2bzsFChHxLeBFC2BNB+kNym+fi7aWhZvZlbJhs2dm7SusEwUhtzfjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204989; c=relaxed/simple;
	bh=pMlOwxm+4BOECjbEuUKVg0zrMxSaNWuR+tQp4F/R+fs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I83i/p3U9aVFea5V984YYgwfNKhj3PZn6sWjHVv5PPIkg7YaWNMB+89gw0afTLtndwh5glU8CVuPEBsJjVPJ/PIxQuOv+PfEeYqZEh54e49NRbaJhLDYvCQLSj2Lyw8KVHbhKFbkpkbKZykcRtkrU9JmOevLNnv1oVSmXrl1BJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHZyT+N4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhI1L3I1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGZ7qrH+XEPXbNu3o6fcBOPQeaxqEq56XYRu8a+p6/o=;
	b=RHZyT+N4vYe1FcMC5cjVsNMaSRBr/0rUEzFExnfJnAQ3fX+sasDxsH6Gw8ING3Bj2x6FzA
	gbHEfzXtU+WIqeTgGRp05Csd9OxJKvHyfmNqNRM3V/K01poyMVvf+IrF3+a1OgCaCPCZO5
	P2x8jVKrZgyhyMYnrF1IU3gNVNzWIUXARI453jLh9VMrXq+j7eGRFGT7vyjIPTZmo3s/w2
	f4PFQms7PdQjo958A8isnNDuRBJmsNPD1H4YRq60qca+uRQRp8TvJfF4iAcMpwlRcUX0vj
	b1rzSNCxwpuWXL2MVtStoTzezECLc5Iy6mR5/eHq1Ccuj9oG6INci9nMow44gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGZ7qrH+XEPXbNu3o6fcBOPQeaxqEq56XYRu8a+p6/o=;
	b=OhI1L3I1PxHIeaD8XTvUfPx7KkU+iawk/KYKuV2l2CllWX3cyJH0SGzUEOkykZtUuMlNIF
	04qjtZcoYML84WBA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf pmu: Relax uncore wildcard matching to allow
 numeric suffix
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-12-zide.chen@intel.com>
References: <20251231224233.113839-12-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820498589.510.11452461799330440092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2246c24426fbc1069cb2a47e0624ccffe5f2627b
Gitweb:        https://git.kernel.org/tip/2246c24426fbc1069cb2a47e0624ccffe5f=
2627b
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:28 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:26 +01:00

perf pmu: Relax uncore wildcard matching to allow numeric suffix

Diamond Rapids introduces two types of PCIe related uncore PMUs:
"uncore_pcie4_*" and "uncore_pcie6_*".

To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
and collect events from both PMU types, slightly relax the wildcard
matching logic in perf_pmu__match_wildcard().

This change allows a wildcard such as "pcie" to match PMU names that
include a numeric suffix, such as "pcie4_*" and "pcie6_*".

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-12-zide.chen@intel.com
---
 tools/perf/util/pmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 956ea27..01a21b6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_name=
, const char *tok)
 {
 	const char *p, *suffix;
 	bool has_hex =3D false;
+	bool has_underscore =3D false;
 	size_t tok_len =3D strlen(tok);
=20
 	/* Check start of pmu_name for equality. */
@@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const char *pmu_na=
me, const char *tok)
 	if (*p =3D=3D 0)
 		return true;
=20
-	if (*p =3D=3D '_') {
-		++p;
-		++suffix;
-	}
-
-	/* Ensure we end in a number */
+	/* Ensure we end in a number or a mix of number and "_". */
 	while (1) {
+		if (!has_underscore && (*p =3D=3D '_')) {
+			has_underscore =3D true;
+			++p;
+			++suffix;
+		}
+
 		if (!isxdigit(*p))
 			return false;
 		if (!has_hex)

