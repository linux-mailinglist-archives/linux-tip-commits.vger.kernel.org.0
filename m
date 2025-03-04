Return-Path: <linux-tip-commits+bounces-3907-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7638A4DA8C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771363B25D5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BD2046B7;
	Tue,  4 Mar 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELApevrY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w0vYS5Fb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2C202974;
	Tue,  4 Mar 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083993; cv=none; b=P/QBz7eqayn70bAFLr30vcjMMJjkxusV1if/aRFYnA6qLQUhP5ytapYG9rIMLWJAihl9uCQjFUirnxCHX2a+bPBHwC0k7TU/sFp1WP8B4gp0oa2436x51MPg94fy7MrgaCzHlUk2HDdt8/xIT43/thNO2xbe6LWovCSeGlpJTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083993; c=relaxed/simple;
	bh=NP9PLM9c91/HpUWLW8InVHb1TkmjEZWoZ8fjVLtukRs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QQ43YZHJ/losvwVh4d3+0rMcEO47IsaXg8VL4HIqOwOhJzTu9hE2qTWHMAAFjWpLv736x/rwHCv8dMttKKVdIafgh7QWN8dYx9/VzKkm+WrGKJb05ZgEZdIedlLhErFgajdtUvIydBsvUt6shV6dTl+IgPyyQz2SCu5FqpOnN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELApevrY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w0vYS5Fb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pArQYtOKuLD/t+TUgDC66fA77LQO/Rai5zODWIcEq1U=;
	b=ELApevrYJxWBMTl8BQzL02y8pQ0dvonDTWuGst6Ej66E7qcfI/phuIjqK1C7ti2l992aVl
	9fGBO0ksQzzBPVBIwg/B/CVbm9W509MEgGHfEbhshQdUJSoBfrdiBM+mUdE1dV1tPwDZ09
	CUsjQn7kppqGcQ3ZAn2GW156kmLnLeGLXUo1zbQzmq8i2N+cVVAk//5CsfCl4g/JiWcuf8
	s4dtWcx+VkxHEWaeao7W9UnAbNgKDkjfg8E8nzqfmGTHLAxMoGzCH8HaCuwpG8jCOUFcaV
	o7udlautFz5PAHaEuBcNJU//cBVQtrnIK7RylOj4bz4MSsSUsW1mCYalopLypg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pArQYtOKuLD/t+TUgDC66fA77LQO/Rai5zODWIcEq1U=;
	b=w0vYS5Fb1R0yp1R9h1I6LDkQs6+6S3EEWG+NO8lwNZ3+I59ewySigeJwOi1MBtVuzEPojB
	HVsL6zZUtrUp+ADA==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] xen: Kconfig: Drop reference to obsolete configs
 MCORE2 and MK8
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303093759.371445-1-lukas.bulwahn@redhat.com>
References: <20250303093759.371445-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108398871.14745.16916807649583411965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     091b768604a8df7822aade75dd5bfc5c788154ee
Gitweb:        https://git.kernel.org/tip/091b768604a8df7822aade75dd5bfc5c788154ee
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Mon, 03 Mar 2025 10:37:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:14:15 +01:00

xen: Kconfig: Drop reference to obsolete configs MCORE2 and MK8

Commit f388f60ca904 ("x86/cpu: Drop configuration options for early 64-bit CPUs")
removes the config symbols MCORE2 and MK8.

With that, the references to those two config symbols in xen's x86 Kconfig
are obsolete. Drop them.

Fixes: f388f60ca904 ("x86/cpu: Drop configuration options for early 64-bit CPUs")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20250303093759.371445-1-lukas.bulwahn@redhat.com
---
 arch/x86/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 77e788e..98d8a50 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -9,7 +9,7 @@ config XEN
 	select PARAVIRT_CLOCK
 	select X86_HV_CALLBACK_VECTOR
 	depends on X86_64 || (X86_32 && X86_PAE)
-	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MCORE2 || MATOM || MK8)
+	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
 	depends on X86_LOCAL_APIC && X86_TSC
 	help
 	  This is the Linux Xen port.  Enabling this will allow the

