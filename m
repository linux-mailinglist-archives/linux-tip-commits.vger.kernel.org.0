Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E523E1497B6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 21:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAYUIz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 15:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAYUIz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 15:08:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1AD20716;
        Sat, 25 Jan 2020 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579982934;
        bh=fyzCA+S+g1b9voiVU+2pgEFejT8fxUzKy55EmnHYVNE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Md3vcYDH2OQGslCG7UQ/QlFWHIVJj2NO5pE0mR+LTJhs8mKLk1utf64N1GkEf6E/Y
         Cx5YOfTjcQQQCX8WaCMSZdMW1EjICCKZaGJILVBwLNFabpboqQl6Pko4QzOCalpRZX
         3uHrgWxJGR5XuRYf6N+I+8Sc4fGn8eH25lz0gHXo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A872352274E; Sat, 25 Jan 2020 12:08:54 -0800 (PST)
Date:   Sat, 25 Jan 2020 12:08:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200125200854.GA8673@paulmck-ThinkPad-P72>
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

> > > If that works, I will re-introduce the warning with proper protection
> > > for the merge window following this coming one.
> > 
> > My big box is at your service if you need stuff tested later.
> 
> Thank you in advance!  I just might take you up on that!

And I do have an alleged fix on branch dev of the -rcu tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

I am just now starting testing, so the probability of failure is
decidedly non-zero.  ;-)

							Thanx, Paul
