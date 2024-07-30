Return-Path: <linux-tip-commits+bounces-1819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C894107F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E1A2822D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC282198E82;
	Tue, 30 Jul 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XgVZUSen";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JfBj4UHV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D651990AD
	for <linux-tip-commits@vger.kernel.org>; Tue, 30 Jul 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339008; cv=none; b=TUgLSFbftt7+r8Y1/dxtzqH/EaVKqc9NmsH+rvAH03yiJM9CYEhMtyYtTxPOLxLh/fGxo+P0pRWtCNJ9fw5h+JiAuZY5kycvsqWPI8GU7bkBrtpjp6hhwj5GDWDOZscYRqoyWHkOuRq85rtvuQEAgBl1LYUPVGqdwsHVLUhT7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339008; c=relaxed/simple;
	bh=Nf4JVj71kkFSUW6FudbA2WAR1mnYciTk2C8b9vmV7n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pztqh3dDWzie4UFUyMjTT01ew3r0ATCVhXdrdUWijjFASedxu9rFHqtb3vFad0jSvZu0jBjKAkewODpGmEVE/8nqUDTH9i2SX71k6Belpx+PdoUVsw8WkhCNFrtbevEt9FiZwB1nUTKI85zFxNhcq47LR03fsOjVGsZ80uXYNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XgVZUSen; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JfBj4UHV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYzVJVnaWKke+HQJcvxnjHoF+YfIox/64/o0Y4enN0I=;
	b=XgVZUSenPtv0yxffn61okj66GmizwKF1eqn21HDN0nmBULthimTErjzshJXoZh6ZPo0aMA
	NVLpfvZJuiBxnsfaDubQoi2e6kBdIbF2MFYlPH1kD6T8YU3AV+fwe5zz9U9ZLsW2De30wc
	8D+SPALqsusUAL3CiVjpiHSrLbUxaIarIJ7TrFO3M8NJnYLQ2EKBqllXm4wJxQ5HU3n103
	Isq31cn6jge462qlZmBQb+fqd5Fb2d9wfmUAwpjUlZJB9OqdvYO3EdNT/FTTQSh+tvaHVu
	fJ1PWIir5MS5SON5D0PwACXrX40TEMN5+gkXYFbI63I8KvX8vz7z+RRM2lWStg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYzVJVnaWKke+HQJcvxnjHoF+YfIox/64/o0Y4enN0I=;
	b=JfBj4UHVkncp84ih5+T5rvIX+3ylSvc1olIHLo2BmHrR/neA5EgK9O20sT83HLBQkB1/aJ
	aA07wo23BsOYB3DQ==
To: Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip: irq/core] irqchip/armada-370-xp: Use consistent name for
 struct irq_data variables
In-Reply-To: <nl3hzgot4di5kkzfoy76vwmgz757nufd2kxfhzz4hxsrpkiyhh@ucftkhmbsphh>
References: <20240711160907.31012-4-kabel@kernel.org>
 <172224658230.2215.2389013389136353122.tip-bot2@tip-bot2>
 <nl3hzgot4di5kkzfoy76vwmgz757nufd2kxfhzz4hxsrpkiyhh@ucftkhmbsphh>
Date: Tue, 30 Jul 2024 13:30:05 +0200
Message-ID: <87o76f6rsy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30 2024 at 10:04, Marek Beh=C3=BAn wrote:

>>  static int mpic_msi_set_affinity(struct irq_data *irq_data, const struc=
t cpumask *mask, bool force)
>
> You skipped this change of irq_data to d.
>
> I also replied about this to the kernel bot error.

Grrrr.

