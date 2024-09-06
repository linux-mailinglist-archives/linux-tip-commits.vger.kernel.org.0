Return-Path: <linux-tip-commits+bounces-2200-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEA896FBA0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96DB1F2AA3B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA11D88C0;
	Fri,  6 Sep 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wdhFWn+F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3uAf5EU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F21D79B7;
	Fri,  6 Sep 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649021; cv=none; b=h6pk2fSvf8Sou0J8o6sI/kssaJvlXtQJr34sMlsnAyfdk9AaifewXe2SB1AjE0kHCjvLv+IMqSYEI55qWr4HIqi9SNhFgZe1OqD4QWyxY1fnLjyvaiMnkcpvkdXvlC9OaS0oRCYtSScuBfiT+eyefc9H56OciY8pCxTiRqyLDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649021; c=relaxed/simple;
	bh=8GZ4IylqyyPKKbKkx8L/HPiVCNqHnyB17N391LuGOMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WAn9hgcvGENt2/nmGMXYQtORcWqqXUN4JmEj6Nazc9x+Lkblvr/HK52NJluA67gmLKOrGAr5b3eVsZURnQRcVdZ/xlYoFTPtVUPS6m2krYzAel7NygdPLaZLibpSgVW3IUk3dtVt6pUHHjqyKZSyFeJ/bNPrNRR8Ty5qq/oEtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wdhFWn+F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3uAf5EU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMA6CS/17rM1x5Uz5lTh7JUD0AcPfaj2BUI2/+O58Y4=;
	b=wdhFWn+FvH6JkUcFgbrPfvLxJgBHN9e8FZOjLCdhgFVdB7W0/mIOTeNvYWBOFas1kC3Og+
	ZQY6Grm3lGIf/nbwo0y0s1B6G1MXTVPE0WwGefmKB/aSYNerECr35iyQ/rfWvumF1t8heH
	5+eQl04oWGP+itrJXOJIuEN8EzNT0bvP2U7rtmT7ZhcuVXLFbwZC830aGBa1j4gBKXWg0t
	GcA7+bjY24lVfaONMtx/K6KpoOTWAb7Bb+i02XDrVPdf6O8sqo0HfV0/EFdCKDCe2p0EAn
	73RvvWuFPnlXbY9h7xmrVXWmCFywDHM8ctKuc075IOKK0nCLRCYNBzN0oNToDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMA6CS/17rM1x5Uz5lTh7JUD0AcPfaj2BUI2/+O58Y4=;
	b=r3uAf5EUKHe8iassKhiPnXQzWp99U/p6hHRH2ol39n0yjFocpOSsQ7x+9nlVGq3IoJzy9J
	Fr1J+K6ihPocgFCw==
From: "tip-bot2 for Detlev Casanova" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: rockchip: Add rk3576 compatible
Cc: Detlev Casanova <detlev.casanova@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802214612.434179-9-detlev.casanova@collabora.com>
References: <20240802214612.434179-9-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901801.2215.10359243983709138633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0c87282074be532eedc8d14ff4420c585c5c57fe
Gitweb:        https://git.kernel.org/tip/0c87282074be532eedc8d14ff4420c585c5c57fe
Author:        Detlev Casanova <detlev.casanova@collabora.com>
AuthorDate:    Fri, 02 Aug 2024 17:45:35 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:20 +02:00

dt-bindings: timer: rockchip: Add rk3576 compatible

Add compatible string for Rockchip RK3576 timer.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240802214612.434179-9-detlev.casanova@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 19e56b7..6d0eb00 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -24,6 +24,7 @@ properties:
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
               - rockchip,rk3368-timer
+              - rockchip,rk3576-timer
               - rockchip,rk3588-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer

