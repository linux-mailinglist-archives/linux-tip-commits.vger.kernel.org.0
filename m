Return-Path: <linux-tip-commits+bounces-5491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D941AAFF34
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7F3B38D2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E97278E68;
	Thu,  8 May 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hv35iCkO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AB275857;
	Thu,  8 May 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718039; cv=none; b=YwDfmE58uF8HWLEVG/1p9H/PXxlmX7zq1SmTzgAIACMlFkMp8Y34M1eCEC9NQLBcNP8k5XXUMdndENb4jWD50HG1Qno+UCiap8x5VO9a5Z5zWX5qEYPmXpgrsNw5LdLlhJax5NJ0EYd88z/WXyE6c+qWsReRnX0Q5J7krbUcJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718039; c=relaxed/simple;
	bh=69n8YK/OegqqW3ok0Zwf8eP/XDNkx7VW6rcIJhLvhHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce11gVPm26qFQI/8OpqA9kj6KrJMItRMN10YibhouKWEVywd/bnJzYu7MF3eepoafuxtn7JRhMM2oGk2oeoMB1H5UnLvUXrxQIAINC+eLkC4gWIKKNYiE/l0tg94xK3lpZA1yyvDlh3LO2A3o/8nJN8lqXHaxt2l/XfkrQbu+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hv35iCkO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/GRajNTedVVAy4K517WUpQHaiRINf22QncvsA8EHAMg=; b=Hv35iCkO64AB988beHRTqRa6sT
	e/W4AucBIS13AkeV8/tnBxfuJSTKk/6UOaJd/dtq3nFM9oXx09a7c3G+oscqz5Ny4P+ZHS/CkmFIn
	uaWgt7xGQAvtDjSq/xAZrSWjNZR6v3ph4i7c8GUKu07vfG86nuPrT6rWAhU3RUZ/mUi+o5HeWKiB/
	UKz7HeWIFpBlWrDhoEfmGECNZfGDE+Cd51sACnGy+qjfhEaAv19Z3mAAa1ypWhEPCxVY9LYR48vcN
	A5IRK1yD9TopdwzTrqPryV/9MVtpXU+EqCHORdeL/+Tpd5ibcgh2zeBZgmIYQs/ff9pL+ZpKGDjuL
	wWcizIzw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uD39W-0000000G6jw-0swe;
	Thu, 08 May 2025 15:27:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F3A030050D; Thu,  8 May 2025 17:27:13 +0200 (CEST)
Date: Thu, 8 May 2025 17:27:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: tip-bot2 for Rong Xu <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org, Rong Xu <xur@google.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Speed up SHT_GROUP reindexing
Message-ID: <20250508152713.GI4439@noisy.programming.kicks-ass.net>
References: <20250425200541.113015-1-xur@google.com>
 <174601619410.22196.10353886760773998736.tip-bot2@tip-bot2>
 <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>
 <yrdh2fmzgqlrfe35wvxb3a2z7wdqod3liupdbriqzc5ihqjw5y@fsqeyi34cbgg>
 <xb2rjui75xylasuihl7gdnovv2z6qxgsefmzhxvhntlcuw5ktb@zbstyytmzjag>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb2rjui75xylasuihl7gdnovv2z6qxgsefmzhxvhntlcuw5ktb@zbstyytmzjag>

On Wed, May 07, 2025 at 05:11:53PM -0700, Josh Poimboeuf wrote:
> On Wed, May 07, 2025 at 05:11:03PM -0700, Josh Poimboeuf wrote:
> > From 2a33e583c87e3283706f346f9d59aac20653b7fd Mon Sep 17 00:00:00 2001
> > Message-ID: <2a33e583c87e3283706f346f9d59aac20653b7fd.1746662991.git.jpoimboe@kernel.org>
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > Date: Wed, 7 May 2025 16:56:55 -0700
> > Subject: [PATCH] objtool: Speed up SHT_GROUP reindexing
> 
> Urgh, sorry about the patch formatting, the above can obviously be
> dropped.

No worries, my script did it almost right :-)

Patch seems sane to me; I'll go stick it into objtool/core. Rong if you
could verify your case still work correctly that would be appreciated.


