Return-Path: <linux-tip-commits+bounces-6207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FCB11C7F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2E4E115D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AF2EAD15;
	Fri, 25 Jul 2025 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0q+d7fMP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="clTimbzv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3C2EAB78;
	Fri, 25 Jul 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439512; cv=none; b=A5BOOawZRKKiTyWndq8GijqhdvE/pXafcIzKuJf5eja5x71u35RO2gTcJOILrdS8QHuof3gFrbR/phc4Nrrbs+q7AgbPCFc0TUokijheWk5v5xttrYeR5S3O47xw3o/mQ47utyaeVDW3F9lgyXeWFmxc5rCjj+GzAqDlhCZjVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439512; c=relaxed/simple;
	bh=J5/OzeUHsKFJTJXo55x8SJRn2H9kj+em4dqJfkSVDmc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kMRH5fzbPftAQz+0RZlzZ/01j2dS4cPz3OozvCDeitWBA2XSJCeV4o5/oN/9PT9Djpn87kB4Du7SL8r+c1QCtX8yDoSoP5lQG0QyEWW+Ynl3t9RsmwF0JcggLL8uhR48VPd3YKFSDNTJP+eFnN82XdL9iHXQ9z+413L/RZ/E/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0q+d7fMP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=clTimbzv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJWCOKj7QJNn1jRCjJyYZ+ubS+PazNR4qpa16+ZrwoQ=;
	b=0q+d7fMPdotfvy/362A8yUd8QaV/+9AMpvZKDk7bU1mGQ+aGy792c6d4e3VEGrOXwD6wFv
	dcA+QNzjqQIpQq2xBqeIws5IjJSCoRsTKY234s49a5s4wr/K9MvQj9vOKqaxnG60OLOfpl
	ZglMz0S19Lmo9Bwpyw1IvBcbliIvu1hGwa/JuWQQz46o0VygDyUN7PsyrnJ30HfbG8/LW5
	kmnSn8b1Kci+ETOr9SFy8jm+RtpkVdU0mg9ddbQ/thy1rnfKce+v6CUr+7XIs4aZTTEPzc
	hDPgzG0uUpg44mbh6luC4kGJu+wcAllyDd+Yr6nPPcsCQdWix5j7fN0DlN84cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJWCOKj7QJNn1jRCjJyYZ+ubS+PazNR4qpa16+ZrwoQ=;
	b=clTimbzvBr+rTCd9XulLZ7LQQr1ZC/oB3pM0yeQwYJeG7E0jMmjAcsCG4A0uySvD+Vk5it
	fT7YnqXqZgRzzNCA==
From: "tip-bot2 for Max Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: mediatek: Add MT6572
Cc: Max Shevchenko <wctrl@proton.me>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250702-mt6572-v4-3-bde75b7ed445@proton.me>
References: <20250702-mt6572-v4-3-bde75b7ed445@proton.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950827.1420.17402370778938773477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     21883cc23c11a675f61cbdd0771993017aa8a0ae
Gitweb:        https://git.kernel.org/tip/21883cc23c11a675f61cbdd0771993017aa=
8a0ae
Author:        Max Shevchenko <wctrl@proton.me>
AuthorDate:    Wed, 02 Jul 2025 13:50:40 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:03:00 +02:00

dt-bindings: timer: mediatek: Add MT6572

Add a compatible string for timer on the MT6572 SoC.

Signed-off-by: Max Shevchenko <wctrl@proton.me>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.=
com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250702-mt6572-v4-3-bde75b7ed445@proton.me
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Do=
cumentation/devicetree/bindings/timer/mediatek,timer.yaml
index f68fc70..d5b574b 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2701-timer
+              - mediatek,mt6572-timer
               - mediatek,mt6580-timer
               - mediatek,mt6582-timer
               - mediatek,mt6589-timer

