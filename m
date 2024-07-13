Return-Path: <linux-tip-commits+bounces-1686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277479304F4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D441F2268D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A466CDBA;
	Sat, 13 Jul 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P05iJI8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/lAD5PdM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB95481DD;
	Sat, 13 Jul 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865823; cv=none; b=HibVgs1ibnxbzK5NggjRy2p8/CEpy2SEI7YbYVTMtVrLUnqMYQK7bqIJHSdmo9znIQApnRFTLGxJ7E+nstS5X+WCv8ujib6UQLO6v7E47gY0T7fJ2CYyBTq+6+MHhFIQaICesuqdIfK34GyWTaffZT7xIGtbNh/roSuGGFhszwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865823; c=relaxed/simple;
	bh=Ph0uJDad46CCRWTBrHBwwauFzpcoF2tO6TCnioxCMv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FLfEXePXesqlQd+hFSOVN5kYiDtUc4qdiW6Jv3lCJLlMXlatKv7rINzvioogbsLykoHNGCV4nel2X+hvb5iByr26cyFJmCrI/eMyct20sFNa7Ynx2XdcKNYW/HmAeelOYMUaWX60iMYz261pSJJ7CJhqpzHkT7Vi+b5wRDKPnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P05iJI8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/lAD5PdM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q306zQeI34icQA+EZBthBWv93Hh8zavCMeu7Ng8Kl4=;
	b=P05iJI8nosU5lc8tFtn0w7p/Ash8GN/8N7xJ8oJown7+RxZkddL0BV+qakYEegykzizFkf
	oYG262aEZHlJfbJWJlI5gg3CeFnHkGOcRPLK/Fn2FtM3+8YIsroBMzIu7PkZovQEVk9pzk
	w51Ddr2eC5yO38cYxOLZLknU6fIjCe/ERxcrhV7bH7/haz3sCJcokzf2oy1pC8GiTL/0CM
	6hM6ozxSPA81mJQKpt4OscqYU2WN579hHUDvV2dxhRm6l5TYkKIeJnqOl99x93AqU9Td8l
	mQYzYgaNzAYY0QIRyuJqrXLbknWSZZgq02osoNuuRRJKMvflzG0GymY2S+vdog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q306zQeI34icQA+EZBthBWv93Hh8zavCMeu7Ng8Kl4=;
	b=/lAD5PdM3pwk7vyczAdX/lrjbQ4uX0oiqZosBwsCKbV9TqgF/2jai2Ok4MiS7G5uuIljVz
	RkHAKNrNGHX92fCQ==
From: "tip-bot2 for Thomas Bonnefille" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add SOPHGO SG2002 clint
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240709-sg2002-v3-2-af779c3d139d@bootlin.com>
References: <20240709-sg2002-v3-2-af779c3d139d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581434.2215.3210881467608415853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f24c0d6a50ebcc154bded7f40c997edc2064043e
Gitweb:        https://git.kernel.org/tip/f24c0d6a50ebcc154bded7f40c997edc2064043e
Author:        Thomas Bonnefille <thomas.bonnefille@bootlin.com>
AuthorDate:    Tue, 09 Jul 2024 12:07:17 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:06 +02:00

dt-bindings: timer: Add SOPHGO SG2002 clint

Add compatible string for SOPHGO SG2002 Core-Local Interrupt Controller.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240709-sg2002-v3-2-af779c3d139d@bootlin.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2..b42d43d 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -40,6 +40,7 @@ properties:
               - allwinner,sun20i-d1-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
+              - sophgo,sg2002-clint
               - thead,th1520-clint
           - const: thead,c900-clint
       - items:

