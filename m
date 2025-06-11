Return-Path: <linux-tip-commits+bounces-5776-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92631AD5AA0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1483B3A6853
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FE1DE3D2;
	Wed, 11 Jun 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LAvDQ6TM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QWbKAOod"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A91DB375;
	Wed, 11 Jun 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656136; cv=none; b=DGbtFCtZaMUTCXKOURvPd5y7jmRyBjgFKNPjCk5u39bANhjLaU1MMr0v1cg0pGBasIdvwGb7Q7f1WMQQphkhacKzrQiZo7UdeLCza4Y/IBaPZCA1jUKT74o0xUdDEoZ4JLUXIMOJVztwR0vjW82V6c0lZNjIWzsvF3NBN1+McPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656136; c=relaxed/simple;
	bh=oHubF8/Fz/gY531TgWWKSo4ut+bnzUEJuuu5kBinNyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG3TBOd5WafdIl319JLl4VudAz1/A/XPCsBvhv6N4fj1Ji+FSLH2ivwDksiTaKRBcqFUqRqc8bXWrjOpLZSgAnTYJNpphTjfsypQyHpocAt5lx1o9uX28haSMgyIm6D+9iNFfPGiOVyNK3u5vs3LH5GRXwjyNnLwJUGIYAWM7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LAvDQ6TM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QWbKAOod; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 17:35:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749656133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHubF8/Fz/gY531TgWWKSo4ut+bnzUEJuuu5kBinNyk=;
	b=LAvDQ6TMQQl3vs9EIBhO9617QwVEl2AVqbIu6OlH9YwKJEJ+1PwTR2hctQ/Q3/7SGmYz/q
	WIPoAaEjxQCXXhRklXJ2t65jxPDlH+XLDBWkowxjT14VsHOlEq8/rbNBQF7EUZdBGnKYaP
	hO0ZrthZ5XBVD82qLxfxgcJu6naQqFMTU7htI6TowqUCorCq7klzcPSyj39FMOa24JWNuW
	4bo36IIMtGqvU8K5wkU3gX53Cn/8+GDqsaMfqVFHcDn5mm6lZvHEIxJXMmigmZAZAa1h6e
	AB1PAXXpDPhh1pGfys+BWPKV0NxqJgdbaQnAPc9w+rTfkn8w0p0zJi6Vi9EHew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749656133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHubF8/Fz/gY531TgWWKSo4ut+bnzUEJuuu5kBinNyk=;
	b=QWbKAOodfr6gCP0H/q3s+zQSlFhkhCBUBQKW8pk0aijRkwnpJ4jrQv9lqyvDJNLh17at9X
	vRpvx2S0rRpnLrCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: locking/urgent] futex: Allow to resize the private local
 hash
Message-ID: <20250611153532.7xToZUwR@linutronix.de>
References: <20250602110027.wfqbHgzb@linutronix.de>
 <174965275618.406.11364856155202390038.tip-bot2@tip-bot2>
 <20250611144302.1MtYItK6@linutronix.de>
 <20250611151113.GE2273038@noisy.programming.kicks-ass.net>
 <20250611152019.GA2273450@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611152019.GA2273450@noisy.programming.kicks-ass.net>

On 2025-06-11 17:20:19 [+0200], Peter Zijlstra wrote:
> ARGH, let me try that again :-(

That last commit 69a14d146f3b87819f3fb73ed5d1de3e1fa680c1 looks great.
Thank you.

Sebastian

