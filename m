Return-Path: <linux-tip-commits+bounces-1954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA094940B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D19B20EAE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF91BC08F;
	Tue,  6 Aug 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VsmNaHH/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BC41C72;
	Tue,  6 Aug 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956198; cv=none; b=NkHEw0RJPZePFVALd+2fn8TFKyZShQDdPfQX7srHvsQwe8+FUQ6hxrjMd8T6g3iwTAIS6sztGp1CYA+2jHpcBy10LEZ+tgAGbXQMucgXWEaoL2FJ9+PHavoaNqVmo4jTnUC3o2dGdCxFzw86cHpvR0pV6xRXeO5ZUzmbpVqTl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956198; c=relaxed/simple;
	bh=NZ+xksPtZrZ7IMxSlps8YwggHHIlieONXX6CdhnrwTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbgWoco9KvKJwCuSgl/fZhvjYYmhTT2bzl7fGBjh77TiUjq3DB1fYA0eh1C+ck9DMnnZcTCIpTBavtmwxCrBgBgV8okH7Y9IIdp+TJ5/mLd8m10q5kuW5TWrLrF3LnoVDq8WyhP3etEIoO63zeN4JBFBCj2LvaI9d9LWRlSXPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VsmNaHH/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NZ+xksPtZrZ7IMxSlps8YwggHHIlieONXX6CdhnrwTc=; b=VsmNaHH/ykUDykn1n1CbzK6zD0
	LUg7oM0KM4gC+5kk+X2OhhR3l0hxQg/tvVUZjs7xeMh9dwky6r6FipmNjSdbeP5uduiinkUS7tL9T
	w0++syvVrM4tw5ElOzsuMlQdZqbavjO2ZvpAh+dqNDSlRy5MGHXuuVlLv/OuzzaTtCAsQPcZ7UUG0
	zqDlTNdeBDsEeXeNk2HlhgJyDSbD+lXk0wfUs5nfdserJskYrBP63P0Pnc2ilw41AKomiwLeTotbW
	zeZzQVYHfOMO4gBznBFCUf4jEJbr9quwzMXy7YUksF5W9qR3F+QfgzTtKokLP3ZCpCjDpD371wmrr
	3o74KMFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLc1-00000005sAd-3av4;
	Tue, 06 Aug 2024 14:56:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA84F30066A; Tue,  6 Aug 2024 16:56:32 +0200 (CEST)
Date: Tue, 6 Aug 2024 16:56:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <20240806145632.GR39708@noisy.programming.kicks-ass.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
 <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
 <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>

On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:

> I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
> the relevant information. Please let me know if you need anything else.

So I grabbed that config, stuck it in the build dir I used last time and
upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
:/

Is there anything else special I missed?

