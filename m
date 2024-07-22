Return-Path: <linux-tip-commits+bounces-1738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB7938FC0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A96A1C203BC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F616CD07;
	Mon, 22 Jul 2024 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNsm2bdC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0C16C445;
	Mon, 22 Jul 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654184; cv=none; b=niIZ41nSS5vIm19uSHoLaaTAQlk888hEYWFAbHIThwGQchKOW8F5BDd+n3vASKg441NcynBFiR1j+WVNBPlzZi44mRnw+yB9XSNhmPz06YmV2E45hqrzR9FJfTZx2oBMoGdv4oey9cxK6QOyZzn5+lwbZ9P635+eqV9kIBRrSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654184; c=relaxed/simple;
	bh=ycFFS4ZpkV7yI1CrnmyQyhMbv8VYnPHPyW5YUqiPfLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSK8Dg18g4Dy3by9qFN7cJ9pQQmQHkVjlmdMeFCWtO9pcGssCw4CV1vCQ5wLxcohxX39eY7bbHg+rHK5P/L5oAzhbt8tQSMcVl9B1t/EgufOACiRyVd4xV1ACvJKbSk1C+wE7Kpo/ePnJyQol+vfOTTS05qwOhC8bBwYulH4mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNsm2bdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D9C116B1;
	Mon, 22 Jul 2024 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721654183;
	bh=ycFFS4ZpkV7yI1CrnmyQyhMbv8VYnPHPyW5YUqiPfLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNsm2bdCH8Ip6nzxx/F3lIgpKA7n9YQoaAyLcm+LyLL9Lnu38sBkAAScKfosAXpiG
	 EIM0byt3HIepoO6JO2TE/6W8veXfH3M01da2r9HrXsdx3Wv9Op4nKgab0B2w7uQWQ4
	 CzMNYzGvEtoKJT/dTODye0da7vk4wC4JnGkHifiTnCvceDHMkEWYPKmKmyAwP7womR
	 hKto0Ny2qidbKxNGTFN5+Mi5ya80INWRFw4CuTd9CAFSV23+UT/NnbazN+BNqM88WG
	 ulznXR2DTaD+7fWJwNJnqvJSOKK9i94vyDMFTyPJ08UPTCz5vJkWnpJ9qzbYfME2ML
	 JVuTAQH2/yFoA==
Date: Mon, 22 Jul 2024 15:16:20 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: timers/urgent] timers/migration: Move hierarchy setup into
 cpuhotplug prepare callback
Message-ID: <Zp5bpLJHlYsZinGj@localhost.localdomain>
References: <20240717094940.18687-1-anna-maria@linutronix.de>
 <172141237277.2215.9152426860884348584.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172141237277.2215.9152426860884348584.tip-bot2@tip-bot2>

Le Fri, Jul 19, 2024 at 06:06:12PM -0000, tip-bot2 for Anna-Maria Behnsen a écrit :
> @@ -1661,80 +1728,39 @@ static int tmigr_add_cpu(unsigned int cpu)
>  	return ret;
>  }
>  
> -static int tmigr_cpu_online(unsigned int cpu)
> -{
> -	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> -	int ret;
> -
> -	/* First online attempt? Initialize CPU data */
> -	if (!tmc->tmgroup) {
> -		raw_spin_lock_init(&tmc->lock);
> -
> -		ret = tmigr_add_cpu(cpu);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (tmc->childmask == 0)
> -			return -EINVAL;
> -
> -		timerqueue_init(&tmc->cpuevt.nextevt);
> -		tmc->cpuevt.nextevt.expires = KTIME_MAX;
> -		tmc->cpuevt.ignore = true;
> -		tmc->cpuevt.cpu = cpu;
> -
> -		tmc->remote = false;
> -		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> -	}
> -	raw_spin_lock_irq(&tmc->lock);
> -	trace_tmigr_cpu_online(tmc);
> -	tmc->idle = timer_base_is_idle();
> -	if (!tmc->idle)
> -		__tmigr_cpu_activate(tmc);
> -	tmc->online = true;
> -	raw_spin_unlock_irq(&tmc->lock);
> -	return 0;
> -}
> -
> -/*
> - * tmigr_trigger_active() - trigger a CPU to become active again
> - *
> - * This function is executed on a CPU which is part of cpu_online_mask, when the
> - * last active CPU in the hierarchy is offlining. With this, it is ensured that
> - * the other CPU is active and takes over the migrator duty.
> - */
> -static long tmigr_trigger_active(void *unused)
> +static int tmigr_cpu_prepare(unsigned int cpu)
>  {
> -	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> -
> -	WARN_ON_ONCE(!tmc->online || tmc->idle);
> +	struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
> +	int ret = 0;
>  
> -	return 0;
> -}
> +	/*
> +	 * The target CPU must never do the prepare work. Otherwise it may
> +	 * spuriously activate the old top level group inside the new one
> +	 * (nevertheless whether old top level group is active or not) and/or
> +	 * release an uninitialized childmask.
> +	 */
> +	WARN_ON_ONCE(cpu == raw_smp_processor_id());

Silly me! Who else than the boot CPU can do the prepare work for the
boot CPU?

This should be something like:

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index fae04950487f..8d57f7686bb0 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1673,6 +1673,15 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 		lvllist = &tmigr_level_list[top];
 		if (group->num_children == 1 && list_is_singular(lvllist)) {
+			/*
+			 * The target CPU must never do the prepare work, except
+			 * on early boot when the boot CPU is the target. Otherwise
+			 * it may spuriously activate the old top level group inside
+			 * the new one (nevertheless whether old top level group is
+			 * active or not) and/or release an uninitialized childmask.
+			 */
+			WARN_ON_ONCE(cpu == raw_smp_processor_id());
+
 			lvllist = &tmigr_level_list[top - 1];
 			list_for_each_entry(child, lvllist, list) {
 				if (child->parent)
@@ -1705,14 +1714,6 @@ static int tmigr_cpu_prepare(unsigned int cpu)
 	struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
 	int ret = 0;
 
-	/*
-	 * The target CPU must never do the prepare work. Otherwise it may
-	 * spuriously activate the old top level group inside the new one
-	 * (nevertheless whether old top level group is active or not) and/or
-	 * release an uninitialized childmask.
-	 */
-	WARN_ON_ONCE(cpu == raw_smp_processor_id());
-
 	/* Not first online attempt? */
 	if (tmc->tmgroup)
 		return ret;



