Return-Path: <linux-tip-commits+bounces-2160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CCD96B866
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5999B27912
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DE1CF5C3;
	Wed,  4 Sep 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXhHR5Fo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jyJ/7grn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACE433C8;
	Wed,  4 Sep 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445535; cv=none; b=mEo3VY4rtfTKrJkHHhRKnCuEQvZwkQ7TVu5y+Hw64EdUaXpC7UMjiln6Cnbr2ycNC5gUufthPjiz+k6B3zSsmrDLC71jHJ+CFSfS3SP/s8qwdHVl5McgTiHUJP9UclLr78KDQoa4Fq1wqLAQOQjoTO2sG4+j81MaTrilrgBZXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445535; c=relaxed/simple;
	bh=ecOyy6jlY74luYoQHrQsxatoyr4/cYcQ6VbC0kGnzV0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jxvWjpK0CCpLSmc2weV7Ey3mGIXKysbphY1VjPzqCPSJovw5tSLjeLI/KVoArwt5PmsS5Wm99Ov12ciAJ/csY5ad762EwxtKX65mOsYfcvAPB8LiSTz4siM5Y64WVoFNQ4/BCXDKT/MJwWSxf8SOHCUtuzQZ4iGOAhF0UsmO2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXhHR5Fo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jyJ/7grn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 10:25:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725445531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qPnZs8knqCXHMzlJrZDZYDiRnx0aG7J65YFOrwErv8=;
	b=GXhHR5FoEu5jJTVLafIM+k0Bnh4ty4SVjK1qYkCoTvfYDbghPnyWDkGxaylZxmnYIMM7Ie
	duNaaB+0fe5cL+I3WLwoPNRIAKv+gSCUiIwIVv2RuDZnq/5pcdamCoAjBFY2ozRltuimPf
	N5HavtaxIQJPFy8kttBcEDJ629bzgEFyMMFKrkutNocnjk2RLpr0PrHEDCUhYDZLH57Mo9
	xK5kQZnKxt1xXXEtK5C3lBoqr0nWehceur866k0ZF5OZsafb4nJLlsS3R+4yxeU+LQzbrz
	6AYmceerTNXO5iwopn7x02lESDzotYQnxzM4WjOpPI6uQK90P0D2GVXl7Q4c3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725445531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qPnZs8knqCXHMzlJrZDZYDiRnx0aG7J65YFOrwErv8=;
	b=jyJ/7grnCitMElunRpHxrmwWhT/HtFt8y7vBEBgrxHXmYw9BY7aetpWZRizGsbnetY5wfr
	8uruK27xfCYCSBBg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu: Fix W=1 build kernel-doc warning
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240825221152.71951-2-thorsten.blum@toblux.com>
References: <20240825221152.71951-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172544553125.2215.2270372187929680512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     8db70faeab9005cbab36e05ba94383075b5cb5db
Gitweb:        https://git.kernel.org/tip/8db70faeab9005cbab36e05ba94383075b5cb5db
Author:        Thorsten Blum <thorsten.blum@toblux.com>
AuthorDate:    Mon, 26 Aug 2024 00:11:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Sep 2024 12:18:10 +02:00

cpu: Fix W=1 build kernel-doc warning

Building the kernel with W=1 generates the following warning:

  kernel/cpu.c:2693: warning: This comment starts with '/**',
  		     but isn't a kernel-doc comment.

The function topology_is_core_online() is a simple helper function and
doesn't need a kernel-doc comment.

Use a normal comment instead.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240825221152.71951-2-thorsten.blum@toblux.com

---
 kernel/cpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c16a9b6..0c9c5df 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2705,9 +2705,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	return ret;
 }
 
-/**
- * Check if the core a CPU belongs to is online
- */
+/* Check if the core a CPU belongs to is online */
 #if !defined(topology_is_core_online)
 static inline bool topology_is_core_online(unsigned int cpu)
 {

