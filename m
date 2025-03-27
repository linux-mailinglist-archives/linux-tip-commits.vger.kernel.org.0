Return-Path: <linux-tip-commits+bounces-4568-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA8A72E57
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 12:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B9F189324B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60E20FA91;
	Thu, 27 Mar 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfFRH3+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCD1FECCF
	for <linux-tip-commits@vger.kernel.org>; Thu, 27 Mar 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073263; cv=none; b=AxRrQJ3tfhl125u8iGusXkLVxlMxT7/edEFb0U7busiV5mvpvoW0jMX7nk3EHlKm4+VETTQrBtEewfiORCEmaapxs+JWu3aWMvDzxZgkiBBsGcB7SNUozRvH/3fu1PHk3inUUR2msYHHBFwOte0v7QiZt5HBjLbTiJRq3WQbbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073263; c=relaxed/simple;
	bh=W1SqF94qWp91NhPfhbNCqJlHD1ZM/m/oT6XdKTD8I+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0XWRN+l99aMeFw+gv8NLntqrqfLZ19ufmsukGiEWL3vlFAYoPayQhirN7Bz/Tqlc2SprqTOQuaxCozH9UILbqRot12cglkXrIbNlMnyD8aaVBHheyyVoUbbK6z/IhTHHO4hEoM/VHYbUNvN9+btLugYTe93QbaMkTa+LunQE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfFRH3+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A55C4CEE8;
	Thu, 27 Mar 2025 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743073262;
	bh=W1SqF94qWp91NhPfhbNCqJlHD1ZM/m/oT6XdKTD8I+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfFRH3+Fpmj/KLGCj+kNXCcWfQ971125fPTtrrRY3bofZhHH7WlJxqnkRzKi7vK7J
	 CmVuc+z90bPu7lsqNA+O6XpkaXwVYzP3CpyD0BkurptDzuFFVnqp62QWKvvSjGXlcs
	 AnLrtL0D2pQE5NyonIMHpaNkgVy0yilUf7FS1WGgJEjBf54k2LUUWjtFc2rH8Z4hs5
	 N82HMpfSaxLv8I1LDVqS+wSPaitxC2txJhN1AwSt2NOp3/mWdFGj9GXitEZl3x97cW
	 /VsNL3aFDf5KTsRmkiLRWpGvIVWqSlYZ1oup5e9DGyOOmSne/0fKR6nqi4tX6EKJDH
	 UesNXU5lgo0Bg==
Date: Thu, 27 Mar 2025 12:00:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-tip-commits@vger.kernel.org,
	"linux-kernel@vger.kernel.org Linus Torvalds" <torvalds@linux-foundation.org>,
	x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <Z-Uv60sD_S2xYVB1@gmail.com>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>


* Uwe Kleine-König <ukleinek@kernel.org> wrote:

> I wonder a bit about procedures here. While I like that warnings that 
> pop up in drivers/pwm (and elsewhere) are cared for, I think that the 
> sensible way to change warning related settings is to make it hard to 
> enable them first (harder than "depends on !COMPILE_TEST" "To avoid 
> breaking bots too badly") and then work on the identified problems 
> before warning broadly. The way chosen here instead seems to be 
> enabling the warning immediately and then post fixes to the warnings 
> and merge them without respective maintainer feedback in less than 12 
> hours.

As I indicated elsewhere in this thread, it's a WIP branch, so we'll 
rebase it if/as we get feedback from maintainers: fix or skip the patch 
on negative feedback, adding in tags on positive feedback.

Does this particular patch look good to you?

> > a good idea to check for the error explicitly to avoid divide-by-zero.
> > 
> > Fixes the following warning:
> > 
> >   drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of section
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> 
> would be nice.

Done!

> > Cc: "Uwe Kleine-König" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM)
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org

I've also tentatively added your Acked-by, if that's OK with you.

Thanks,

	Ingo

