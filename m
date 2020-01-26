Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6F149868
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Jan 2020 02:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgAZBnT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 20:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgAZBnT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 20:43:19 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AA720709;
        Sun, 26 Jan 2020 01:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580002998;
        bh=FcOjPSty7BSfPV7GNUzQSplEPafYw/6PuF71Sj14S9E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UvZWIFP6V2sGmE4oI0qIsAzv1JOU/S46VjUMIUARkZAvOV73x/nMgntQzJitSNUuI
         i57iK5PMV3ns0FxpdFUplhssa+Dh5N3ecH242oB7pBBYH7dPRJ1AzTqwEhwTHzYaOA
         GQmNkzW6AQ/71aUeP67WQQwgGkCvJ+fTRpqn0aWE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 96A703522863; Sat, 25 Jan 2020 17:43:18 -0800 (PST)
Date:   Sat, 25 Jan 2020 17:43:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200126014318.GA5122@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125194846.GF2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, Jan 25, 2020 at 11:48:46AM -0800, Paul E. McKenney wrote:
> On Sat, Jan 25, 2020 at 06:54:42PM +0100, Borislav Petkov wrote:
> > On Sat, Jan 25, 2020 at 08:10:50AM -0800, Paul E. McKenney wrote:

[ . . . ]

> > > So could you please try out the (untested) patch below?
> > 
> > Warning's gone.
> 
> Very good.  I will get it property prepared and tested, then send it
> along to Ingo.

And it passes my rcutorture testing as well!  If it does fine with 0day
and -next, I will send a pull request Sunday evening, Pacific Time.
In the meantime, it is right here in -rcu:

59d8cc6b2e37 ("rcu: Forgive slow expedited grace periods at boot time")

							Thanx, Paul
