Return-Path: <linux-tip-commits+bounces-4555-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5AA70E93
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 02:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7031716E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 01:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB8322B;
	Wed, 26 Mar 2025 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5isTd8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5EEEC3;
	Wed, 26 Mar 2025 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953579; cv=none; b=rZBunxiw53cnVFbtirqyHtTS/1pXCtIOvXveULe7t5WusyNXdRz9OcucXm8J8whC0cjCDmI6T7NYeHdkLyil3fNTlSCh3jSov0+/tfDvfFjRA3200JpyDSAhDujeMEA3vzmhSi8vSvioEwQmengTFt3rCt2sDkK6IONwZCLKE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953579; c=relaxed/simple;
	bh=VYDRUzsbwI5tJrmOYcOqRdaiJinko9uOWTmLeWYfkQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpmsZh1BuMF4gE8ovrsuWmcJGqJvGomjZ5Tyk3+kWTc4zPJIgnjWX5VaPQXOujsrmeNEGfaBnM0er8NMBPo9mR5qGXLQPf1zJMBzk5UjKOAOMOIpmr7geXgB4XakdbiUao24ZjTa5BiME1GQjy8I4CDk5y/0pG6/7NCfP2gIEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5isTd8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81379C4CEE4;
	Wed, 26 Mar 2025 01:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742953579;
	bh=VYDRUzsbwI5tJrmOYcOqRdaiJinko9uOWTmLeWYfkQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5isTd8bWqPiT/jYIdMvB0RQBh2R4+II1CkXzDbSLAguG5BSw5KJtintpyjdQKpqp
	 U94CV9vK6hnF6XwUJy2iiSSEbswM18oNsuHavygni/GkXDHPAC6/slyH78X4dlYgDy
	 liBYq7e+e3NqmLplMflasiIpLjGDiQn03wuRvytmziqwXlu6oERttimntDby9Z/nqF
	 8CulrzEIHFpD7YsZ/hMj/A/TCE3NOUJEV4Wl6WRDOoQ+wGJtIuIqd9bBT9Setxlz1B
	 0YusUm3ufOyudZwXnexh0n0Kmsy0CWPKPjJnmHTnGek7k5Skn7b19sYuc/BLHT8WYE
	 +1uNoLU2jItfw==
Date: Tue, 25 Mar 2025 18:46:16 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, media: dib8000: Prevent
 divide-by-zero in dib8000_set_dds()
Message-ID: <w636w4p7xtg4v2lbuic7dnxs7how7mqp2ipkp5xyvfbqr3idvs@oxnon2piapsl>
References: <bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org>
 <174294059839.14745.12160091729171456650.tip-bot2@tip-bot2>
 <20250326064239.5194fdc8@sal.lan>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326064239.5194fdc8@sal.lan>

On Wed, Mar 26, 2025 at 06:42:39AM +0800, Mauro Carvalho Chehab wrote:
> > +		u32 internal = dib8000_read32(state, 23) / 1000;
> > +
> >  		ratio = 4;
> > -		unit_khz_dds_val = (1<<26) / (dib8000_read32(state, 23) / 1000);
> > +
> > +		unit_khz_dds_val = (1<<26) / (internal ?: 1);
> 
> This is theoretical, as in practice dib8096 won't likely be tuning
> if reading this register would return zero, but at least for my
> eyes, it would sound better to set unit_khz_dds_val to 1 internal
> is zero, instead of 1<<26. 

I don't pretend to understand this device, I just figured one is the
closest you can get to zero :-)

So something like this instead?

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index cfe59c3255f7..c80134ff511b 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2705,7 +2705,7 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 
 		ratio = 4;
 
-		unit_khz_dds_val = (1<<26) / (internal ?: 1);
+		unit_khz_dds_val = internal ? ((1<<26) / internal) : 1;
 		if (offset_khz < 0)
 			dds = (1 << 26) - (abs_offset_khz * unit_khz_dds_val);
 		else

