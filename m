Return-Path: <linux-tip-commits+bounces-4444-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1FA6EB48
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F67E1894AC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E10255252;
	Tue, 25 Mar 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnHSIuMW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1orYrj1I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7925487F;
	Tue, 25 Mar 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890502; cv=none; b=Vk/VjEkI6XVosODMFN4SAm+5w8M5UyXPyoN5EzXNkHpGUxLjgDhf6JEjkFsiC1df1QHTfnBlKXju2zOYbFDXMs9alb7W2XFx7j87agy++yNc2IM0B+RtQcn+x9ENceq18VqvdMWjWhpMj3iih7Bnd/CA3jZ9B4jHoNvQFHdr//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890502; c=relaxed/simple;
	bh=PRfvcpmqEOui/2QO0o9viskU5Swy7tRoh/MMfqfHDJM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L3NZUdYYMFMWzrHPzuZPcOBESmfaOmCc22nWWmljvNn5Qh79XZNForLjCkm2XkuL4eYgD9UWE500KxQZuflRbH0bw2u0fTLRxfYXWTz/1gSXHCllWN/nZD2uivw9t7jOoRR5m4XiQgjZggB6YVFRlINCo0nQqRWYkMUslY06YX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XnHSIuMW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1orYrj1I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qS6VNIeZUcSdPwQT2+hjmu/ftR0VMU/OawUXfvjY28=;
	b=XnHSIuMWKqNosi28F6V5Cr1OdfYQO6x6kdg2ccISooim+JoxpEdosjHiQtfAn7gKl9CNdf
	CvOxKaRmjcRyvzWfND3MOQ7nIh9njYBNSHtfygw5xVX+DFHxpu9fPRKhmYBdNFPH7b79Eo
	px5noWI9jPxCIB5t5zOL3SkHjydMUkc7LTn09p6D4sINXLbLuUmG/UFd0GFnEyYhL4vKsT
	IYstyTJOClrrOfRogC1d7x/lr/LOLe1gGhv8h0qYF+82ct24OHoy8juIEz3su194ewRDGR
	jQw33S/JsmXdjHqV+jo8uuDontpRilcRdt986C89exQ4NwwKzEjVJaUj2FdSZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qS6VNIeZUcSdPwQT2+hjmu/ftR0VMU/OawUXfvjY28=;
	b=1orYrj1IksshDp23kHXP5VPoCQpoMqyLlxt0Xnrr3Rhh+/a50zPX7ntH5XrZtKwszKKbQr
	FaMmDtCN310eGrDg==
From: "tip-bot2 for Igor Belwon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: exynos4210-mct: Add
 samsung,exynos990-mct compatible
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250104-cmu-nodes-v1-1-ae8af253bc25@mentallysanemainliners.org>
References: <20250104-cmu-nodes-v1-1-ae8af253bc25@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049825.14745.8166565010501434724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     f4646b61b74b43c7b0e5f2e0426393aa9e216923
Gitweb:        https://git.kernel.org/tip/f4646b61b74b43c7b0e5f2e0426393aa9e216923
Author:        Igor Belwon <igor.belwon@mentallysanemainliners.org>
AuthorDate:    Sat, 04 Jan 2025 21:54:16 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 07 Mar 2025 17:55:59 +01:00

dt-bindings: timer: exynos4210-mct: Add samsung,exynos990-mct compatible

Add a dedicated compatible for the MCT of the Exynos 990 SoC.
The design for the timer is reused from previous SoCs.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20250104-cmu-nodes-v1-1-ae8af253bc25@mentallysanemainliners.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 02d1c35..12ff972 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -34,6 +34,7 @@ properties:
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
               - samsung,exynos8895-mct
+              - samsung,exynos990-mct
               - tesla,fsd-mct
           - const: samsung,exynos4210-mct
 
@@ -135,6 +136,7 @@ allOf:
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
               - samsung,exynos8895-mct
+              - samsung,exynos990-mct
     then:
       properties:
         interrupts:

