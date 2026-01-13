Return-Path: <linux-tip-commits+bounces-7944-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A7FD18A14
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E8BD30185F3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FECA35BDBE;
	Tue, 13 Jan 2026 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEzKFKdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLoGqRF5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081C2877DA;
	Tue, 13 Jan 2026 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305945; cv=none; b=Y28htrQ4qbznPWuyUpbvMkbDjQhniYWdBP8phdzFgo7QaNWD9k1HIAOQbniPbxpdnp0pikM06hykg8AEIWgZ9jbtVU/c0AdztJ/VT/nKO+AeCTAbbC5mpfqiNFGzff6njD/BSyBsryNnAz4fGjX8LyZtUslqA4URid08hgjK+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305945; c=relaxed/simple;
	bh=tqu2y2ghrRw57Q2Ic3qgkutW+rCt1U6B/NsKG+gJHzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjeKVxkA70lbc5XvoiTwnGv0F+urLFYUzX49DahM2Y510a2EZx2umCa5Vo+FjrIW7hxMi5ZYVAABgqVNZzhygzJ4AWWrNJXAd9HryMybg7f2JNMMHkt057kH30uR22febMR2d1rz/XcbGtxg1iVEuxHBldCJ+YWSLM29CmLUuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEzKFKdR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLoGqRF5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:05:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768305942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buzJ1HyJDrtLpI7W0hxK1ZYkk6Jyui6QcTtq8D4u6sg=;
	b=gEzKFKdRTY32yTmwJEf2r8k8m1Y6U5hifcshqMBD0qE3KDsLj0VvtOcbPptB+kt2+oKQXx
	b0wgRnOq8NH7b7OQBmMQifgPO9Ew5JSDsSKiGvc/ZzeTcXCCUHH6MNWW52zyG5L9axuGsK
	l5R3WvpMiVSbNq8EHEvcigO97/3a/JIeKZNHBv8nDVq53B5R8iFD2IcrWaZDpV+wd8NIbL
	nQUZMCcoGwhnKdP38JzffmFDzzW89DwvMdf7PDHG2GB8L0Gei3ugk69AaJNGSkK8TXIRI9
	UUjaW0VYlOhM8tjN7Jb8lFlwnfJlGs2PZxikqllORmXaiPySjDXPen3aCTqbxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768305942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buzJ1HyJDrtLpI7W0hxK1ZYkk6Jyui6QcTtq8D4u6sg=;
	b=sLoGqRF5Ygw9QO0XW+8ma3zlu9lyFsguRR4E8Tcf72FNr+daUYVCHOW1zswx5f9JOvtEMt
	nXhT5hho3zxaMeCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	x86@kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Message-ID: <20260113120541.YVf2vRA3@linutronix.de>
References: <20260112134013.eQWyReHR@linutronix.de>
 <176829473742.510.5940174319056100768.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176829473742.510.5940174319056100768.tip-bot2@tip-bot2>

On 2026-01-13 08:58:56 [-0000], tip-bot2 for Sebastian Andrzej Siewior wrote:
> The following commit has been merged into the irq/core branch of tip:
> 
> Commit-ID:     aef30c8d569c0f31715447525640044c74feb26f
> Gitweb:        https://git.kernel.org/tip/aef30c8d569c0f31715447525640044c74feb26f
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Mon, 12 Jan 2026 14:40:13 +01:00
> Committer:     Thomas Gleixner <tglx@kernel.org>
> CommitterDate: Tue, 13 Jan 2026 09:56:25 +01:00
> 
> genirq: Warn about using IRQF_ONESHOT without a threaded handler

Should I pro-active send some patches to those users which I know do it
wrong? Or do we simply wait?

Sebastian

