Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819424354A6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJTUis (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 16:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJTUir (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 16:38:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679BC06161C;
        Wed, 20 Oct 2021 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zgWlttlDPtcOgs6vxCorZjvcpxSElGqbyfyNg0gmDOM=; b=o+rg9L9dX0yfV3uy8eFJtPoHHZ
        WWLy4isBXtAMS7wBJK+uPELoxYFufyoLgGNZfiUxm7+wtPpQbYp4emBGyD8y0F6ij0xSpaYXQZmY6
        0tg5PLc7F8R0ntDUbDbmCzZhRANwHh61n517YymUOs0yYY52Dy201KeWp5N75iQwrGkLwvYOZseR8
        LbNpAnYSbv97AMnOVPEpUcuWgZ5EqwLWnwiUlrt9QRDjfSTfrAknIq7wDF1VqHgsfh7GuSdMvZ1uo
        /FRN6Wm6AjRP2NPcz6Ck8rymmxQ94tZHc5b9pF01yAzocPr0VKQ5isj/tMfm2+zeZS7q6G811Gys+
        7D6rB37A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdIJv-00B1zs-Fu; Wed, 20 Oct 2021 20:36:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CD7B986DD9; Wed, 20 Oct 2021 22:36:19 +0200 (CEST)
Date:   Wed, 20 Oct 2021 22:36:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
Message-ID: <20211020203619.GC174730@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
 <20211020202542.GU174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020202542.GU174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 20, 2021 at 10:25:42PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 20, 2021 at 03:08:41PM -0500, Tom Lendacky wrote:
> > On 10/20/21 2:51 PM, Peter Zijlstra wrote:
> > > On Wed, Oct 20, 2021 at 08:12:51AM -0500, Tom Lendacky wrote:
> > > > On 10/15/21 4:44 AM, tip-bot2 for Tim Chen wrote:
> > > > > The following commit has been merged into the sched/core branch of tip:
> > 
> > > 
> > > If it does boot, what does something like:
> > > 
> > >    for i in /sys/devices/system/cpu/cpu*/topology/*{_id,_list}; do echo -n "${i}: " ; cat $i; done
> > > 
> > > produce?
> > 
> > The output is about 160K in size, I'll email it to you off-list.
> 
> /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list: 0
> /sys/devices/system/cpu/cpu0/topology/core_cpus_list: 0,128
> 
> /sys/devices/system/cpu/cpu128/topology/cluster_cpus_list: 128
> /sys/devices/system/cpu/cpu128/topology/core_cpus_list: 0,128
> 
> So for some reason that thing thinks each SMT thread has it's own L2,
> which seems rather unlikely. Or SMT has started to mean something
> radically different than it used to be :-)
> 
> Let me continue trying to make sense of cacheinfo.c

OK, I think I see what's happening.

AFAICT cacheinfo.c does *NOT* set l2c_id on AMD/Hygon hardware, this
means it's set to BAD_APICID.

This then results in match_l2c() to never match. And as a direct
consequence set_cpu_sibling_map() will generate cpu_l2c_shared_mask with
just the one CPU set.

And we have the above result and things come unstuck if we assume:
  SMT <= L2 <= LLC

Now, the big question, how to fix this... Does AMD have means of
actually setting l2c_id or should we fall back to using match_smt() for
l2c_id == BAD_APICID ?
