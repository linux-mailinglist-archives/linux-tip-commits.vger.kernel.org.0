Return-Path: <linux-tip-commits+bounces-1253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885A8C22DC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 13:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903A9B21012
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC7F16EC03;
	Fri, 10 May 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snl4n13I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sg5Nvm9I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE321340;
	Fri, 10 May 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339459; cv=none; b=BfXTNnW8kZqfE+fbkSRxZPJoMuuya04IK/bQFFkcr/wRCJNn59SNjsSeleuOjAXzzC2ouPEiOZhKcYIVwmbDcktUDE/r6bpcT/CqTpjpgcwYYyr9gx8mV/oZLXoWx8UAysdF5YyrCzYSp7eG6pqj493gpVliz0oSY0M6Lv5B7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339459; c=relaxed/simple;
	bh=WARjXBjaXmZapGq0zOvicZwFNttRZAAucDmrkNJsgm8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sWMd0yZjmOqC+IrHo693eDqnYvvnJQxn5kGAH24ogiNZJfRBAyFsx96PfzPFKNagHwTEUoafdWtj1wV3LsyIkmzuAS3DvuxkrAMdzixy9kSugxq7fjEn0GCfXwze2Y9n1Ky9LNMRTQq3RvobsKwxVrM8wJRPuTH6Ofqe4HbtcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=snl4n13I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sg5Nvm9I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 11:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nqJjVWBCGlLKjOFQA9kWPXiu6byz0/fW41RnTPxi74=;
	b=snl4n13IbM3sIwPfJ/6tJ8sJ6lsdGVXgAKQAvhhfOcb01g9tR4yMuTw7Pg6gcYpca0CJ28
	r2h2aLsN+CPIRX3upnY76nJpN4gmh1iECniarhy0hm0FJwlSPbkEBXHDsvlzW3BMMUIAbM
	Ts61d9M5tfkMwL9P74e+m7O+qPedutEPjGKuOYfpGBuyVocy6jqOaJZiFTS2eVdhLuVeBZ
	cjb1ani0Er/6uqTCmFO9/74I8BhqGrdFXwhMplzRJJuRJBKKQSmramUxMz5u5JrMA4PwEv
	ujkGEZ9dW8FsArlxFDhZlsMCVBJt9XkKdZHUgdiEkZ8Jtr1HbmWgIE7LRci6Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nqJjVWBCGlLKjOFQA9kWPXiu6byz0/fW41RnTPxi74=;
	b=sg5Nvm9IdlF3x2sexJkjO4bebMt7EZ807iYO9bKbZrJ8OfbEykS5F9PuJXURIp85d9s7jm
	wDlTVTM5JHuceUBw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas: ostm: Document
 Renesas RZ/V2H(P) SoC
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240322151219.885832-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322151219.885832-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171533945631.10875.9914941562694538725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6402eb802deb312e33c24699f68fb7775b2c7386
Gitweb:        https://git.kernel.org/tip/6402eb802deb312e33c24699f68fb7775b2c7386
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Fri, 22 Mar 2024 15:12:18 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 May 2024 10:41:52 +02:00

dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC

Document the General Timer Module (a.k.a OSTM) block on Renesas RZ/V2H(P)
("R9A09G057") SoC, which is identical to the one found on the RZ/A1H and
RZ/G2L SoCs. Add the "renesas,r9a09g057-ostm" compatible string for the
RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240322151219.885832-2-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 8b06a68..e8c6421 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
+          - renesas,r9a09g057-ostm # RZ/V2H(P)
       - const: renesas,ostm        # Generic
 
   reg:
@@ -58,6 +59,7 @@ if:
           - renesas,r9a07g043-ostm
           - renesas,r9a07g044-ostm
           - renesas,r9a07g054-ostm
+          - renesas,r9a09g057-ostm
 then:
   required:
     - resets

