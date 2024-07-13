Return-Path: <linux-tip-commits+bounces-1687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4429304F5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1B71C20F7E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCFD6EB46;
	Sat, 13 Jul 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzeJMGyd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZEjCN16"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD04964E;
	Sat, 13 Jul 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865823; cv=none; b=W6Ne13oHT1Z26NAbV0XFt3si4nKH903vzlgB6Dy51+Sm31fo2wi8EmjTnzHk5rXLn9Eei2wDy7sto8lPC+q3M1PUn1Q+itLnJSuQSjtv9dbw4lE1IL3+GeFVuRFSKVTb0aqXIKK5REYZR/+O3M7DqM44ten45efwBx0O7UqL7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865823; c=relaxed/simple;
	bh=lWzmlhc8B93Vx0k7pTLJAjfqcPpUlrajmAnnWwUrZfQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jK+Om1BmYlRGJlez72YJF0dBjqHVeAyj94BKoH65fqHvBlVUHRDPS6PR7l5YVMJp3eO1iB7p23A3L+Br/0VGc6B3eSQ+uKl/OBwRspbLDanX6L17Z3Q6P4dHZENH4WcY/akvjp2GaSvxv7pcBXnO9P+Z7OeaiXqwNK5F0v9Xi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzeJMGyd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZEjCN16; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gvT6D9mSx7a1QNpY/v7P266qslkoEPban0i4UxdvII=;
	b=TzeJMGydRII7e0xljvSs2YynxaiOySsKRxD2KOuRN1ter27NyVdPf2QVpbJaHfncglnxUP
	+IidBHoNaPQ7qgw2cVaRMM+nLjvl75i2d/grFbNK7dvZ8YBNvCRWymZrueQPNilkmUwBBO
	ZS9R6/1Ah/6uF2r1u3mpNVG5TnyuLCsyFaQJAt8GrxHfJQOU/pWjHpMyn40VyHieKMzjTw
	s6JekC18sZOOs773IF3BxGmH9PotPIfX0fWLsn8nMYzGEfJaDPvPE7k63Z68UwtRwwySqN
	rIDlpU5VUlUMeemOAbBUJGHBaqfiql3Iy1hkW1N/jtXzGtrnv8heZl3clbo/pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gvT6D9mSx7a1QNpY/v7P266qslkoEPban0i4UxdvII=;
	b=wZEjCN16+uOr9NgNyHGobRAt3+IzI4QGrYPv6NXLdOUZFnIAVMBw6KsElg3DapJPlWZqC2
	khHY6XdXgCelwLCA==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,tmu: Add RZ/G1 support
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>,
 niklas.soderlund+renesas@ragnatech.se,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbdc30850526f448b8480d9a5e65e35739f416771=2E17169?=
 =?utf-8?q?85096=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3Cbdc30850526f448b8480d9a5e65e35739f416771=2E171698?=
 =?utf-8?q?5096=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581483.2215.13201762963376294517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c1028676dc859fbef9de21f0312df347cab515ba
Gitweb:        https://git.kernel.org/tip/c1028676dc859fbef9de21f0312df347cab=
515ba
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 29 May 2024 14:22:05 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:06 +02:00

dt-bindings: timer: renesas,tmu: Add RZ/G1 support

Document support for the Timer Unit (TMU) on RZ/G1 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/bdc30850526f448b8480d9a5e65e35739f416771.1716=
985096.git.geert+renesas@glider.be
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index 33170da..cc228ed 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -23,6 +23,11 @@ properties:
       - enum:
           - renesas,tmu-r8a73a4  # R-Mobile APE6
           - renesas,tmu-r8a7740  # R-Mobile A1
+          - renesas,tmu-r8a7742  # RZ/G1H
+          - renesas,tmu-r8a7743  # RZ/G1M
+          - renesas,tmu-r8a7744  # RZ/G1N
+          - renesas,tmu-r8a7745  # RZ/G1E
+          - renesas,tmu-r8a77470 # RZ/G1C
           - renesas,tmu-r8a774a1 # RZ/G2M
           - renesas,tmu-r8a774b1 # RZ/G2N
           - renesas,tmu-r8a774c0 # RZ/G2E

