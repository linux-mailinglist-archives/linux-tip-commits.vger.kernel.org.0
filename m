Return-Path: <linux-tip-commits+bounces-1955-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522DF949428
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15B31F27003
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328D1EA0C4;
	Tue,  6 Aug 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHSfNC7e"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56301D54FB;
	Tue,  6 Aug 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956720; cv=none; b=l6ybCQb76PHfoKnu/RSX5bvjpFpDXICd9c8oT3HMW61GwMoYMFNe+c8A4vekc5lnN57lWJPqk06w1R/LvxZnjGGO00JFctyj3aN3iI6ezz9dCUsjk5tQ0YHk+EQsmiapr42MCIAA6l82Fr2bFlqDxWJBy+RL96zyZcp3s1WNhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956720; c=relaxed/simple;
	bh=udICwCBvJshjtVZs7gtly5jRvCos3Vlp9LlZX3uPxic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgnbBntNiXlcsUFcbh/ZrGvw+CbA6Z5Dwpw0/FivPeHb4qQnwcVgg6gEMAZkm0Fb23LaPGu3Z2uB8LG23RYHYggoZVQIRflayTuAlHo8gdLK1iZ8sdP/qCG5Dhze1yK/HSHIJEwt0dKe++AFwpXkUxw3dWFWYu4cdUGnkDEqFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oHSfNC7e; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g7/z3cR/Twtrn5FHIQO54HzbyScbHj7IzKCsLCpGlqg=; b=oHSfNC7ebJ7mq2xuSnvTLpMVeT
	jHs4mxU97jA4Uoz4pX+af9+sGRFz81auzkbDX09uAsx+x7G1LqdrL5vUG2PDpoyvW0GplCH3xs7wM
	KoN3qyCz/1ObIFckR/UK5Q5hGOop15U8fnwI4HWAjFGz3U2b444Ck96J4q9qs2WM7xXLkxcphnUgw
	2V5s+eTt0coOUg8Nfr7YOov6jBzhoDkS2/7FjjePlsxqO608cpy84f/+MdBzXcgNg0yN/1Tjef2uN
	EaF2sE6zFJZ1kwMyLA6nfDNJ+HcFXuqNPSFLiFlC7ILBJSWgoz+zzSpeRpdA1qafRnq8zfYf2xChc
	/g9alBMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLkS-00000006Tya-2vNK;
	Tue, 06 Aug 2024 15:05:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D373730066A; Tue,  6 Aug 2024 17:05:15 +0200 (CEST)
Date: Tue, 6 Aug 2024 17:05:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <20240806150515.GS39708@noisy.programming.kicks-ass.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
 <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
 <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
 <20240806145632.GR39708@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806145632.GR39708@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 04:56:32PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:
> 
> > I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
> > the relevant information. Please let me know if you need anything else.
> 
> So I grabbed that config, stuck it in the build dir I used last time and
> upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
> :/
> 
> Is there anything else special I missed?

run.sh is not exacrlty the same this time, different CPU model, that
made it go.

OK, lemme poke at this.

