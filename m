Return-Path: <linux-tip-commits+bounces-4443-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86EA6EB47
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26E67A5BAD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA425522E;
	Tue, 25 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbNTnBnQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RpA5Q1O8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2117254854;
	Tue, 25 Mar 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890501; cv=none; b=GuohYnNLWJFaHeqJIw/at7y65WVqDleiiQ/ffCwGjHGeXT6ZyR89S404BY928j4CplVQlP4dIZ5s7NWSwCyCOkSNh/p5fXzpypOy7aRN7kEg+vYzVMcrN2g5V8Ouxo/Fabs1lGnBCatj0mLnf65O52Mf3myBxvgIKS9J8axOe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890501; c=relaxed/simple;
	bh=JIX3GKWg2DCftb5JPoSVxnYDk0Jgbf93Asd1L3nkjKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oc0paSFDzWpqkcviOg3NlTUw8PkvXjyt8qhYc5guw3r1HQJO4KYOftprkxchq1B0HTNJPIaQF93zNey8AFlGfRKzwxKpqggZNGw8qhbIST3mZQdPzJHuuReKgPcA/GcMyFqqQHothRA8gAzijMnZQJEfBFi3KhXfvcVtFbQz7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbNTnBnQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RpA5Q1O8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxzOikjE1bY+ETSXVMzuP1neSRQd/e25jelOisjtr+w=;
	b=sbNTnBnQHyUDpy2m/6/Kx7PY1O+Gf8YvvgnaSqTkSbBhs3dGTs4PqSns4f2ltg6Hng6plj
	NZkNHKB4gt+HQuWsKZmHAv3YF2CRdqKYg4+Y4tWX13wL5iHroHWSFBJwpmiyYZs63CZcL2
	CcE2HuoZ/vr3w1D8PyH6mE7Gp5wA6+ICs5ouA4/U6YG3+11MDaEjtdh0/NPjUDdhKI176H
	5I1FswT5sw1Jl85j6eVifSLa3SRu8iWpCOvr2Ow75CzGHK8/s/RtnalbteACxbtW2g0Z/I
	2mjTYbhEefzI+Kxa+qzhO9vA3fBR7thlEduYjtJKYrL/UaG96nphCDL1JoEmSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxzOikjE1bY+ETSXVMzuP1neSRQd/e25jelOisjtr+w=;
	b=RpA5Q1O8YC/uIlrB0quVsu1jBSOkYRXV8nhHfm66caf6HH5fKQcdujvzrOp56/9VQCIKYm
	j3jo+MR/0dAzrhAg==
From: "tip-bot2 for Ivaylo Ivanov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: exynos4210-mct: add
 samsung,exynos2200-mct-peris compatible
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250215123922.163630-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250215123922.163630-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049747.14745.17998179915074618512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     f7803f7905e133a5fa5b596da5bae89b1528757e
Gitweb:        https://git.kernel.org/tip/f7803f7905e133a5fa5b596da5bae89b1528757e
Author:        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
AuthorDate:    Sat, 15 Feb 2025 14:39:22 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 07 Mar 2025 17:55:59 +01:00

dt-bindings: timer: exynos4210-mct: add samsung,exynos2200-mct-peris compatible

Whilst having a new multicore timer that differs from the old designs in
functionality and registers (marked as MCTv2 in vendor kernels),
Exynos2200 also keeps an additional multicore timer connected over PERIS
that reuses the same design as older exynos socs.

Add a compatible for the legacy multicore timer of Exynos2200. Rather
than differentiating it based on the block version, mark it as the
one connected over PERIS.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250215123922.163630-1-ivo.ivanov.ivanov1@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 12ff972..10578f5 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - axis,artpec8-mct
               - google,gs101-mct
+              - samsung,exynos2200-mct-peris
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -131,6 +132,7 @@ allOf:
             enum:
               - axis,artpec8-mct
               - google,gs101-mct
+              - samsung,exynos2200-mct-peris
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct

