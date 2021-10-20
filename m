Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF343548A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTU2Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTU2P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 16:28:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD0C06161C;
        Wed, 20 Oct 2021 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gdq6vEXjE75oDDEEwHZTpvZFVnJ7Dy2pN7aHyORL3pk=; b=EKhU65wAxfIEWbMFFOjOlMzpky
        Dma2uPrNWd7TjmYbITi4n7kHjs35HnX0EnJ1LE52dE90QeI1/TMc/dtSG2yivZCq9lc+IvdoXbBRo
        bHQ6tCn8rdO5/8+Sj48vkgYJLUN5F6IOEiOPFSrAHU92l9gtks8ttPjbsLw8kETifYysE3rc4m7I6
        uKGcflne5dvdl65HaEC014KwW5ISxgTQ8huFLw97fg2M9CjzC4m4AGsRYJHUibTWx7NkTGwcMwVKD
        YZfjLdBfhCkAJJWEmgfX3FcfvLc4qW+i4WeP4ROOi6P/Sno2LLoz/kyauLHlDxgq2v2OuIc3LDiRs
        vSJHbzxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdI9f-00B1oP-Ts; Wed, 20 Oct 2021 20:25:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE1E1986DD9; Wed, 20 Oct 2021 22:25:42 +0200 (CEST)
Date:   Wed, 20 Oct 2021 22:25:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
Message-ID: <20211020202542.GU174703@worktop.programming.kicks-ass.net>
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
 <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 20, 2021 at 03:08:41PM -0500, Tom Lendacky wrote:
> On 10/20/21 2:51 PM, Peter Zijlstra wrote:
> > On Wed, Oct 20, 2021 at 08:12:51AM -0500, Tom Lendacky wrote:
> > > On 10/15/21 4:44 AM, tip-bot2 for Tim Chen wrote:
> > > > The following commit has been merged into the sched/core branch of tip:
> 
> > 
> > If it does boot, what does something like:
> > 
> >    for i in /sys/devices/system/cpu/cpu*/topology/*{_id,_list}; do echo -n "${i}: " ; cat $i; done
> > 
> > produce?
> 
> The output is about 160K in size, I'll email it to you off-list.

/sys/devices/system/cpu/cpu0/topology/cluster_cpus_list: 0
/sys/devices/system/cpu/cpu0/topology/core_cpus_list: 0,128

/sys/devices/system/cpu/cpu128/topology/cluster_cpus_list: 128
/sys/devices/system/cpu/cpu128/topology/core_cpus_list: 0,128

So for some reason that thing thinks each SMT thread has it's own L2,
which seems rather unlikely. Or SMT has started to mean something
radically different than it used to be :-)

Let me continue trying to make sense of cacheinfo.c

