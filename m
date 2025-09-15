Return-Path: <linux-tip-commits+bounces-6636-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B493BB5788E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BED544584D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD252FE59F;
	Mon, 15 Sep 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LxVX6H7d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KsYKdHyd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF52FF14E;
	Mon, 15 Sep 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936163; cv=none; b=YyzvwykeDwAK8Rkld3nqxvBoEGXtm5rfqqfxgP1xNuWKeY8ygvnX5kCn5nPLzBEPxB4oFBIxG10zNyUmVnLf+Z6KrhAAxVn3Cs2jpqlNHQ8kWChVrikqqgMcY5FsTnkdVxpDCRo55K1X58hdtBDX18A//R5VNrHep7YcroyiVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936163; c=relaxed/simple;
	bh=+GaTjELvGfZ68ssK3i0uR8G7nprGnf9ixDcMeyx4K8s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WUzWCn/995tJozcR/iUhYgfRfC7VaGjG7p5WDJ8oVnHQmDJmUihyCj+OhwXBFGwzpoXGkro+cz6vukDzXCRinGu5f0qElVzrXdVLGnyFkHacCpl1q2GoLbXdzd9leKQkx3EZASeb2AU3l7JrafSnQ0zI4+cXu+n6XM8ZOQwP02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LxVX6H7d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KsYKdHyd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=un+UHez12NRAzDv/rwghHCASFEOqcI+hmQ8jp10v0gY=;
	b=LxVX6H7dfAx5J4xkn2o+zPPAY4GyEJQGn9e03xCl9+AWG+CIOASOtpGQM/O9TonmwNgGeP
	bFeVcwxeFKcm+Z1ZocUisdAn6UGBddIqWnnWOipT7UiiZCpcSQvAqQj6yhz/sJeeIMAWai
	nR4F8Hf9eZNGXT/GJCQ3+5zLSx1RvUhK2dvvVueroVIud9b0s64ELDZRDj7eyRgREjFxJL
	CtFujbMGV9Qi1oa/ldHy9bnR+OnshtChXpV+WC/tPuThCHL0/tRNffGF9M1JWaqBJpJGKy
	NKyXSp3KDEkycIhi5b22lxbbLTlB10gnltiObr1wBrg5xk0z+Fj93vUZAzjl+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=un+UHez12NRAzDv/rwghHCASFEOqcI+hmQ8jp10v0gY=;
	b=KsYKdHydM1a7t+5YN0jIhatLErwzrvHz6uIOEliaFpdffKHwJwEBUuRcK1DXJL6ddBLWbp
	PdN9Yf4s2F8HRYAA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] MAINTAINERS: resctrl: Add myself as reviewer
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <be18d59ef5458b22ef65fac59d9c2d06eda01d57.1757108044.git.babu.moger@amd.com>
References:
 <be18d59ef5458b22ef65fac59d9c2d06eda01d57.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793563912.709179.17740541135656750861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d79bab8a48bfcf5495f72d10bf609478a4a3b916
Gitweb:        https://git.kernel.org/tip/d79bab8a48bfcf5495f72d10bf609478a4a=
3b916
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:32 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:58:22 +02:00

MAINTAINERS: resctrl: Add myself as reviewer

I have been contributing to resctrl for sometime now and I would like to
help with code reviews as well.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f620696..bee4e10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21175,6 +21175,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 R:	Dave Martin <Dave.Martin@arm.com>
 R:	James Morse <james.morse@arm.com>
+R:	Babu Moger <babu.moger@amd.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/resctrl.rst

