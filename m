Return-Path: <linux-tip-commits+bounces-1392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C990903B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Jun 2024 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56632B2B754
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Jun 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6951192B8F;
	Fri, 14 Jun 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVPHDs/W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NxWfA11p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D239181B83;
	Fri, 14 Jun 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382289; cv=none; b=XeZqlU33SpPrgrq9haL62dznrXcWN0gk/yZ4gwsXw8cccHvbHZVgXdtdp4sv71GlTgr4adQDxiB/rc9Js/2gSiCmO8fqfeZW81FXym4SEIPOjyIF1JWXp3GaPUPvVjd7E2Pz/7/wDUOvpWsCg8IIE8gLKOIuW4WEwhnbqpLBUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382289; c=relaxed/simple;
	bh=EKQrL1WVhOejUZxSOfRUXFQ03K3aLjiBgaiCiz8x1JE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J5JQ5yxFu7ILCtksT5B1NYcMvS/jcabk7noZTE2E51tsbORKp+3vdpCkHrDBqgbYcCHzVWLxqmUFBqMmlCytZHWc4Iw6fU//fKpvCtX9YAqttxyAN2Y0w3lK4DM8q9LtuBcvC9OyVifch4do5TNNEw2rTb1bfg/3wKScA+Yac5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVPHDs/W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NxWfA11p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Jun 2024 16:24:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718382286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zi3eDCZPt1+laq1+hbEpP2aXW8/aqgek8mV2yMUgYJ4=;
	b=KVPHDs/WkjYeXbgxOO+lW3QVsPW9vOsR8mfxFfOMRFszKYqj+CPGzL9wsWpg6AlZ7pz/Vx
	iCrDzNxaQycW4YQekngZZ+3zI5ROWlj5zSOGf01WzxCt8g+rnO/R6WfxBgltE0oAsgBru0
	6sPloqFtrH2+uINkjWy4gUluj4PMImjm1amu76Z4MIdHyhX6BF4Yol18EnCCfH+BjnlRpv
	EWdQi3tHFxx7lx4d+Cei+4Z5qM+UF53uK5khd5D2q41mh0bJ7+OYWI+px9PElGoCnY9IRU
	3aP9xkhJgGs6DxRquw3dwI5V+GzguY8RRSIHjeqM5u2jr4gpXbQdCYAuMJmaZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718382286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zi3eDCZPt1+laq1+hbEpP2aXW8/aqgek8mV2yMUgYJ4=;
	b=NxWfA11pYAWIQ0SfJCe0S+fOMHDIoIAXJJAsFZ/Lus26jMD816WE6H76ivXT3xv4Ms+acI
	NEGUWv6usyiZk4Bg==
From: "tip-bot2 for Thomas Huth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Documentation: Remove "mfgpt_irq=" from the
 kernel-parameters.txt file
Cc: Thomas Huth <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614090306.561464-1-thuth@redhat.com>
References: <20240614090306.561464-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171838228571.10875.9678006095453472995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     9b9eec8dc284f33f505cec48d88b42ebad4da9cc
Gitweb:        https://git.kernel.org/tip/9b9eec8dc284f33f505cec48d88b42ebad4da9cc
Author:        Thomas Huth <thuth@redhat.com>
AuthorDate:    Fri, 14 Jun 2024 11:03:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Jun 2024 18:06:57 +02:00

Documentation: Remove "mfgpt_irq=" from the kernel-parameters.txt file

The kernel parameter mfgpt_irq has been removed in 2009 already by

  c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code")

Time to remove it from the documentation now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20240614090306.561464-1-thuth@redhat.com
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df8..fa76802 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3429,10 +3429,6 @@
 			deep    - Suspend-To-RAM or equivalent (if supported)
 			See Documentation/admin-guide/pm/sleep-states.rst.
 
-	mfgpt_irq=	[IA-32] Specify the IRQ to use for the
-			Multi-Function General Purpose Timers on AMD Geode
-			platforms.
-
 	mfgptfix	[X86-32] Fix MFGPT timers on AMD Geode platforms when
 			the BIOS has incorrectly applied a workaround. TinyBIOS
 			version 0.98 is known to be affected, 0.99 fixes the

