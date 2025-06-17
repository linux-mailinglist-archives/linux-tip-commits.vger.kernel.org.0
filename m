Return-Path: <linux-tip-commits+bounces-5857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AEFADC730
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB163AF137
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Jun 2025 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB6B2DA77E;
	Tue, 17 Jun 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29/u/7to";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40rKDl2+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D772E88A6;
	Tue, 17 Jun 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153841; cv=none; b=kVEVl5xsLeuSp0kWLeW7K7V2C22+tKJRCWpQYjrrwbwVmnQ1srQ3CfNM6R4mj9qQWGKBcs94+5cgntSHLwn2mqszWGF/b6k4xyrtl8itk3VY5i9fa5ALfBEo4dyqnR9dYNS5M2pbrI60eyS3B5abz/CMctLkRWdxsZyaNjR2zJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153841; c=relaxed/simple;
	bh=F+NNae5j6roNMnAwHtaBB3EaYMmWL30/CvMUIRhP0JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpmqYVX/srTNzh1KpXKQ6SH1tIX7KdExzM+3P+i1Gps1fp2m4YwnUlRGjpKDtFlXCTk2ioHU2ph+EQt3VJxJIxRhDfw1/rXI+y+nX2LtPztlD3vQ8scF1Rq7BbsIT8g38f0ECRofFUpKacvg31qZyYHJfTb8LEEi46I5jw7rEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29/u/7to; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40rKDl2+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 11:50:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750153838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+NNae5j6roNMnAwHtaBB3EaYMmWL30/CvMUIRhP0JM=;
	b=29/u/7togBJUz+9YjY1KcNqHlA5EuE4XPm0Sr1+wApiCiUe3orocTppBn3lG9U30jZVAYs
	Qtz2uby1oFxZwJuCmn2NzSRYZfaR0sDQqKuDS9dZUmHfuspaCjrH1eWT6QqfTMdTgcWfE9
	imO9jWG4is3ikR/uRMvVJZ68Ld1Am9FXEhS3ok9wVsxJCtPxc6HU6cLci0Js/gujSurgfv
	KZTkWuDCn9rlUgpiYKflA4OWJFyw3NNEdKSaVoVJfGs80xrFoYq1dEAIkDXQ9rQ+P678ls
	U4X1NPCpOPOv3tOKoSNfMex7FzScxMacimQGtpA+Op7U3Zg59VuGmYeLdGFA2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750153838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+NNae5j6roNMnAwHtaBB3EaYMmWL30/CvMUIRhP0JM=;
	b=40rKDl2+l84+NRSoBPOG4wzzEy+LSeEC2hMY4NZeazTggWEz/WWvJFRrZZr3/Qe2iflpVD
	YQY9jdY/EPnmiFCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250617095037.sOnrJlPX@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <aFBQ8CBKmRzEqIfS@mozart.vkv.me>
 <20250617071628.lXtqjG7C@linutronix.de>
 <aFEz_Fzr-_-nGAHV@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aFEz_Fzr-_-nGAHV@mozart.vkv.me>

On 2025-06-17 02:23:08 [-0700], Calvin Owens wrote:
> Ugh, I'm sorry, I was in too much of a hurry this morning... cargo is
> obviously not calling PR_FUTEX_HASH which is new in 6.16 :/
No worries.

> > This is with LTO enabled.
>=20
> Full lto with llvm-20.1.7.
>=20
=E2=80=A6
> Nothing showed up in the logs but the RCU stalls on CPU16, always in
> queued_spin_lock_slowpath().
>=20
> I'll run the build it was doing when it happened in a loop overnight and
> see if I can trigger it again.

Please check if you can reproduce it and if so if it also happens
without lto.
I have no idea why one spinlock_t remains locked. It is either locked or
some stray memory.

Oh. Lockdep adds quite some overhead but it should complain that a
spinlock_t is still locked while returning to userland.

> > > Thanks,
> > > Calvin
> >=20
Sebastian

