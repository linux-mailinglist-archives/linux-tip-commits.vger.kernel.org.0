Return-Path: <linux-tip-commits+bounces-2440-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27999F222
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01EBB2269A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD231F76C2;
	Tue, 15 Oct 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E1Gw3woC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hMq8ALNo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12F1F6681;
	Tue, 15 Oct 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007883; cv=none; b=BLv0HikdKUqsv0JuzrZELObt4zxk2WBe5Ph+/VOP0eOMuqP3TcKaB7jFRhQMPzz7MmoG9sWcVLMpDmG1dppRy+xZEozmb14QAOrqx5BapEXMfSWQPM0cKu8YlN0OTbIIsUPehjWs/RBtHC+XloZ2umSuFBazF87+okM+FPB+1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007883; c=relaxed/simple;
	bh=O367Kz30znmQmgJkGmtmUTvCJA70lRJhasz6yVc2RQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+pi0Gz6OwORP1R4rVrHM4TOtIg6mjNqX1dm3sUUS993+yzJjLfugSaMA0Vw41QjVf0Ii83Fm7jtcEa81PfL0XhYUTm89mUSDOMs+BL95DOW1IPK8fIPe5xhv0Yk5sjNMr1in1lOUb7BjHMt7VIjBuC7WwpXlxu2wd3IEU3BmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E1Gw3woC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hMq8ALNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007880;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iISszkvY6EzQUTy0I8rK0BEue6SdzjI9sm5Wro/uvW8=;
	b=E1Gw3woCnZUPyJqpzRoTBMOYeSViTbHSaZslh2WKRfHnf1jhCtpxy63Yc72TACq/g89MVb
	BMIMJRywsME7oV4UVuofW7IJU/yBF4CfV772mL6LPeWVyu44kjAokYHAZX+BumChFOwaM1
	7NgRGthscr7RAe53ZIroZYtRZFvD0Y7hn9+EhddMQZt7pQhWEaO4kFtWYB0kBvp24BFcSZ
	CALd23FQYsCfUuUZiXrNe0qSELOoJkM71Y6mCLnugTQHxIcINjrjFeDffi3PrNOLy8Zklw
	OUcaODa+NbhwCUgyOVhWW2dwQLy7MfumrYZ9Ggk88wGlkeQro5MRFz7RoS/nVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007880;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iISszkvY6EzQUTy0I8rK0BEue6SdzjI9sm5Wro/uvW8=;
	b=hMq8ALNoAnySQc2xQqElppDoD0xJBwGWpx4zPbaZVAxlGoubBZf7G+rLYHVF1hnXlxzrAE
	2ZTp5nclCfsejrAg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vdso: Remove timekeeper include
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-3-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-3-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787937.1442.4471012513191531082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     8603652569f9c10744f204466dcf527653591d1b
Gitweb:        https://git.kernel.org/tip/8603652569f9c10744f204466dcf5276535=
91d1b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

arm64: vdso: Remove timekeeper include

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-3-7fe5a3ea4382@linutronix.de

---
 arch/arm64/kernel/vdso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 706c9c3..8ef20c1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -19,7 +19,6 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/time_namespace.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>

