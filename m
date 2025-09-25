Return-Path: <linux-tip-commits+bounces-6723-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D41BA18AF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BE0740505
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B35E286D70;
	Thu, 25 Sep 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sPFoi9qw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uiqJfIrM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF8CA6F;
	Thu, 25 Sep 2025 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835972; cv=none; b=ZvRzhYWBuTOGqlGqNix/bpjazuECx5ns/0MgyxvBRWFsuUtZPPmXECqhVe/VQLeoCUIkB2EJyFupyVE4muAqXbuL2eOjTffmEcbSe+IreVYMoT1c2bPna9Xj6MlICIMhvi968ECROINbXWU1vciP156w0qKnDfVqRDawx6bJ5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835972; c=relaxed/simple;
	bh=qGAMtQI/6eiOIpRCFVxUbNjawPZeeYjJacfTyW+AZrA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bQorfcOb8ct/44d4fwOMmDndjbEFIBV1jFR9GJX8WVihrshpCEoitA1wrW6UuXNZaVlvtJgXJL//TC4BBKvhFWx2gI3Cn7MU+qV1PqGvOrbr2LrX9fs6gq+6YkhFa3Fsp+nkOj3D2TSP9JuLANXWv0lZESxfFOUHdMhNieVNPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sPFoi9qw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uiqJfIrM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BDQ6UqQKeJDe0qy5OF5nUe4LeujLahu+Z64vtPiq2Cw=;
	b=sPFoi9qwWGIIdqhAcwJkNR6OGoPwm6iCGSg79gD9c5kWgbqhrpLRSDNOPz6W6Urn1oRp1r
	OprKL10oS/NYTHcTBOBraDOV+UUXxwMRYIEKYPUT0QWHr+m5aCDjYEvVTsSfiVNAZ5m7QE
	+qKuOWHs6ypeagrowuuAXLELTKh0J4jRKnnXe32zbeKWqfHgAjzY2Lh0g7MUz0h8KRaxRe
	w9JXpUjs+MV4325jrk74Yd8HczlsAfKOldZxBuDZKqZnZibsdLU28iFUesn5Ft40ZrCeX9
	QVp4dkESOcVScWqBPlXTD5Bf6g/eYpXF2EnV70Dj6CX9DBAyYA9GWIM+Axx+6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BDQ6UqQKeJDe0qy5OF5nUe4LeujLahu+Z64vtPiq2Cw=;
	b=uiqJfIrM/ZFWAVxLtz6YP73Ust7Cb5WDJs3OYyW8++H+020Z4nQNXpMDKCVF/vYh3/r/Qs
	2UOr6qbmdA9asuCQ==
From: "tip-bot2 for SungMin Park" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: exynos4210-mct: Add
 compatible for ARTPEC-9 SoC
Cc: SungMin Park <smn1196@coasia.com>, Ravi Patel <ravi.patel@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883596528.709179.13968239970984180775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     45d78cd0bf2c40e74c31f70340484e20aae45b07
Gitweb:        https://git.kernel.org/tip/45d78cd0bf2c40e74c31f70340484e20aae=
45b07
Author:        SungMin Park <smn1196@coasia.com>
AuthorDate:    Wed, 17 Sep 2025 12:43:11 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 24 Sep 2025 15:46:27 +02:00

dt-bindings: timer: exynos4210-mct: Add compatible for ARTPEC-9 SoC

Add Axis ARTPEC-9 mct compatible to the bindings documentation.
The design for the timer is reused from previous Samsung SoCs
like exynos4210 and ARTPEC-8.

Signed-off-by: SungMin Park <smn1196@coasia.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250917071311.1404-1-ravi.patel@samsung.com
---
 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.y=
aml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 10578f5..a4b229e 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - axis,artpec8-mct
+              - axis,artpec9-mct
               - google,gs101-mct
               - samsung,exynos2200-mct-peris
               - samsung,exynos3250-mct
@@ -131,6 +132,7 @@ allOf:
           contains:
             enum:
               - axis,artpec8-mct
+              - axis,artpec9-mct
               - google,gs101-mct
               - samsung,exynos2200-mct-peris
               - samsung,exynos5260-mct

