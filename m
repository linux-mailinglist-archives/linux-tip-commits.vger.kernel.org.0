Return-Path: <linux-tip-commits+bounces-1690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC949304FC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1361F22543
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAED133406;
	Sat, 13 Jul 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Svn93VGM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HhCHGTuK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB997345F;
	Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865825; cv=none; b=Vay9zOoJk6XAFQLfM7woMxdOEebWilGtLQQXu9sPOTbnhg9VKeY0fBpYSlgNfGy1MTpYeXjpkmyoj1a52+9B+cV5HPv3K1Lei7oZWUP41PfK7Eo/8bJhpWhJqI6TaAa1wHigLqgmQhedi5Sv1LBfOX950GYuvQ8/aBfoEQF5Eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865825; c=relaxed/simple;
	bh=eZZgK/HK1Jv904vRiuqcTvJ2gq4CPbJ8eJtXz31Aw8Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sAXD55885m5Qw8pzf9ZEpxNKBczIwOqM6OIUGip1t0X2Y7qkjjNPGa4MrHznbsA68RTta3cVugo4NpzlKaQVpk+diGzKMjV+9RbJXd0sn9mU1SCZp7wkPNUR9/TFWxoukBOM1y+TU3J/8InGZp5w7BtEyErNkCCv9/dWaRvwg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Svn93VGM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HhCHGTuK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esMeOGLU1cbZVBiVhR+VE5n/Zrncw8ByKE+2p+nhl8g=;
	b=Svn93VGMf+YMSTSKWREteCb3gvx6q3wIHplxP5k/NbE213tvNO70GCqwdQaH7JlMfGgBfd
	3rPpKQqurE/Fvw+kMBAerxmbMVAMqtv4EgcJbEmadjwD2Krb+zNODrSDmvrbjg+6PlnyRl
	noVgJfrWOn4AeWsYJQgvYO1xveJV3dmLQZIr+pBqNhqICGNMVqCQo3ZAsLFRH6J2tUHmS8
	q2z27jYgkHq49lt/nhQvQ+mNa1x7yRsLHOso/DjdYzWap9EimR5Z/1dqyOSxkJl/guRjyY
	7mpbKf9lJmRCkwWMWAxKUWWA09sQQR2T3aiUNUGQ4vEfbxunArx/FUs70iPyNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esMeOGLU1cbZVBiVhR+VE5n/Zrncw8ByKE+2p+nhl8g=;
	b=HhCHGTuKZG/8YttSAT0UkjM+aW/34rAgYgIkQqB9Fp3Cw/5e/+4INF7NAN4OErLF17THuU
	hgptkaTJgruXN9CA==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: renesas,tmu: Add R-Mobile APE6 support
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>,
 niklas.soderlund+renesas@ragnatech.se,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C17e3fd5f27ab540c8611545ad3dc5a697ca66c58=2E17169?=
 =?utf-8?q?85096=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C17e3fd5f27ab540c8611545ad3dc5a697ca66c58=2E171698?=
 =?utf-8?q?5096=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581503.2215.59484725550794141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     17c103b59c3b995eb9d2944067593f2c9cc13652
Gitweb:        https://git.kernel.org/tip/17c103b59c3b995eb9d2944067593f2c9cc=
13652
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 29 May 2024 14:22:04 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:05 +02:00

dt-bindings: timer: renesas,tmu: Add R-Mobile APE6 support

Document support for the Timer Unit (TMU) on the R-Mobile APE6 (R8A73A4)
Soc.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/17e3fd5f27ab540c8611545ad3dc5a697ca66c58.1716=
985096.git.geert+renesas@glider.be
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index 360a5cf..33170da 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,tmu-r8a73a4  # R-Mobile APE6
           - renesas,tmu-r8a7740  # R-Mobile A1
           - renesas,tmu-r8a774a1 # RZ/G2M
           - renesas,tmu-r8a774b1 # RZ/G2N
@@ -94,6 +95,7 @@ if:
       compatible:
         contains:
           enum:
+            - renesas,tmu-r8a73a4
             - renesas,tmu-r8a7740
             - renesas,tmu-r8a7778
             - renesas,tmu-r8a7779

