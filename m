Return-Path: <linux-tip-commits+bounces-2669-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04F9B77FE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203431F2441D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA5199231;
	Thu, 31 Oct 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DjKw+eak";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20G4j27E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EB1991BE;
	Thu, 31 Oct 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368281; cv=none; b=gmLc4oSuf/nqxf6LubStJG1XE/Es3NqydHPjY5/1fceTDo7ROz65ZRsrYRtScJ5KGiuCp95DWnncINZ1b8a8kJyOb6rjq1wXicgE1xTRJJiU8b4l9u1YLuxhGt1oLN5diAL//9Z5ozqQDKUg7tyMNvk2fcNgZNGvQbZPChsJfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368281; c=relaxed/simple;
	bh=K3ksZGdn4eOTfwv64FdtBeWzoqFVagwrqIOsJYdfls8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ta6zrEeHtONc0b4lZIFLWZlUqXk3dD3liFE9hKfqs37cwYl02wRTY3aEU+VRH/h18ZUFJi9+j1ZyLCjVHKjbLnqB57S7ZBIXLODllkLj+/1zrwvw34H5zCAmHbgd62c41Br40Fko2OtFXQozpgrAVDwKno3IMNX7yEcz3Ak1tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DjKw+eak; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20G4j27E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKfG8sr4IGvhftMJTwVvXKqhma8JN4X4qqY+kjtYWaI=;
	b=DjKw+eakzHNWTytV9Luv3DODpNUtgAbOUxMwrwPN2tiHCW9BPDGjMHdJclrrDgyjU5/3m3
	IZJKy1KDBOaVSq8jCtnvJGRfbuZmNFu4TFl4QYfjz5Kb/19OFvUqRqGMBlzs4AD1P9nUo8
	Qr9WgttFFdmIHAdEwG+57G09rip5wiEThWiSoAt95CrA4UoyAtCPb+F+GYneFB6m8aVtN8
	gtB6fqwoc+y+iFQduJH8R+VRLZLI7e9aZJ1KgYlWYq2e0db3rbvdAHitUm5QM2zHUZCoxm
	DCnNOAFMe045zoCdDXfBLA78X/CLiJuxJbF7mJ7HqtR8/MlwRcpTG7F9tK3euw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKfG8sr4IGvhftMJTwVvXKqhma8JN4X4qqY+kjtYWaI=;
	b=20G4j27EDVI+cgu6Slr7dyRRUpW6bRSALwtexMfkxGy/KFOwaqy7T4hIC20aauzCGECBo/
	raXK5d7v1j6BVpDA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: smp_twd: Remove clockevents shutdown call on
 offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-5-frederic@kernel.org>
References: <20241029125451.54574-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827667.3137.2931381099278182189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     900053d9eedfc3f731e59a27d24da938907f5407
Gitweb:        https://git.kernel.org/tip/900053d9eedfc3f731e59a27d24da938907f5407
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:42 +01:00

ARM: smp_twd: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-5-frederic@kernel.org

---
 arch/arm/kernel/smp_twd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f72..42a3706 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -93,7 +93,6 @@ static void twd_timer_stop(void)
 {
 	struct clock_event_device *clk = raw_cpu_ptr(twd_evt);
 
-	twd_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
 

