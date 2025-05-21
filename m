Return-Path: <linux-tip-commits+bounces-5718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327EFABFA6C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D13188199E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24722228C99;
	Wed, 21 May 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LxYN+5cm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+TFZuiG+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAA227BA4;
	Wed, 21 May 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842578; cv=none; b=YxWL+A6gPbpeM5hDMdAe0bGKJRVA2kB5qr/LEBnoDMVX3bibhEowRRCJa23ri8Z31uITEBoUb4gykkwAxP9KJV07HXr5ghH6rFFY1iX8PE5AEA9OFCcKvggqzSh6uHcMKYqwCRBftTs2V/otDf1k+MTJS88CxtxTggJiRr8SVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842578; c=relaxed/simple;
	bh=+eIHLKlB3m9h3txg4FPvGyJv9d45hnjLW9twXz9aSlE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZAl0Ev/rAJN6cpelExspwTqXm3n1XTbnd0dDHcvGs++FoFSuSRaYFf0jD5e+xDxZNDeq18CVFuat8DWVzV/sBHrW1jZc0kB8jIxe7jXt4NLPuc1PowdE6pMdra6rrkWUAtc1KGrmz++jIQ5pCQSVbFRe8iGakmcifaNiG8eZXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LxYN+5cm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+TFZuiG+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u63FRrFnIJArMmJGkvpu0JUACZmwR81v1rj3Xu0ZvBE=;
	b=LxYN+5cmPjqzbM2WAtZnxlMThHcF0Aa9FrbUrzZHnEuBcn6XXiXzTrnI1yC7b18+5dWdIc
	75uhm39ZnA1+MFwfkdTV/wUA9CclCH/luSBXsDyRldvhWTyVtkSlI4De8rmFEnOSNflhjV
	pELto1H/Cf4pctcpSXWEBsbbKj3RJc0P3ajf94U+EjqhO4tknWJMuFF8iRGADN+sMZq0Uh
	vjz+E7X5ZXCZ9LX7+ZY+YCstmlKZ+rl/as55euX7iFga6Dtcz4kqa+EJl5oljRDjnuyBQQ
	dKAIVDRgIFxk0vKUtVpZ5KQHoEx88Vs/twdOXL/oWQfjsqxjbKJFrT+qaaqSGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u63FRrFnIJArMmJGkvpu0JUACZmwR81v1rj3Xu0ZvBE=;
	b=+TFZuiG+6n34/EuL+0oD2JsfZx6m6LXbUxEws7MXOw12hcP60gxtqcIdEtMgZVLpORiRXZ
	DsmXqaeffFDAmPCQ==
From: "tip-bot2 for Darshan Prajapati" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add ESWIN EIC7700 CLINT
Cc: Darshan Prajapati <darshan.prajapati@einfochips.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250410152519.1358964-9-pinkesh.vaghela@einfochips.com>
References: <20250410152519.1358964-9-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257392.406.10780208654660770750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     6d1ca2236dbe987f0fb9fa194916fb453024b553
Gitweb:        https://git.kernel.org/tip/6d1ca2236dbe987f0fb9fa194916fb453024b553
Author:        Darshan Prajapati <darshan.prajapati@einfochips.com>
AuthorDate:    Thu, 10 Apr 2025 20:55:17 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Add ESWIN EIC7700 CLINT

Add compatible string for ESWIN EIC7700 CLINT.

Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250410152519.1358964-9-pinkesh.vaghela@einfochips.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 653e2e0..d85a1a0 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -30,6 +30,7 @@ properties:
       - items:
           - enum:
               - canaan,k210-clint       # Canaan Kendryte K210
+              - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540
               - spacemit,k1-clint       # SpacemiT K1
               - starfive,jh7100-clint   # StarFive JH7100

