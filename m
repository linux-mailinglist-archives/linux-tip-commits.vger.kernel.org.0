Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9153C2A9B3E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Nov 2020 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgKFRwy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 12:52:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgKFRwx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 12:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604685172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXUD4PEw11l15dp1gG3X4hb7MCsDOoZml5dxfjumYcA=;
        b=ZFKvUcHsGzLQ1jRB+ppGZjyOl/hslrPRIy3hXnSAdn39EU49rI0kbcyETkxh5Zk5eo82AO
        3vdfaZS/VD1lUYtnpGeSS4z1Zo5nNLBRuj9Fmt1Vm46cbIaKpmF3Tko/EZR+WYCR3bb1Eq
        HhjYJyv3mrTG428/q01qhXQY3JuKz2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-zFZeb4IgPLe8zQAoK78mDQ-1; Fri, 06 Nov 2020 12:52:50 -0500
X-MC-Unique: zFZeb4IgPLe8zQAoK78mDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1907F803637;
        Fri,  6 Nov 2020 17:52:49 +0000 (UTC)
Received: from treble (ovpn-116-174.rdu2.redhat.com [10.10.116.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90AF75576E;
        Fri,  6 Nov 2020 17:52:37 +0000 (UTC)
Date:   Fri, 6 Nov 2020 11:52:31 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [PATCH 1/1] x86/tools: Use tools headers for instruction decoder
 selftests
Message-ID: <20201106175231.f64g7c6f47gq2mty@treble>
References: <patch-1.thread-59328d.git-59328d9dc2b9.your-ad-here.call-01604429777-ext-1374@work.hours>
 <202011041702.EIrDb4hS-lkp@intel.com>
 <your-ad-here.call-01604481523-ext-9352@work.hours>
 <20201106112413.80248e44fef68d9acf932dec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106112413.80248e44fef68d9acf932dec@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Nov 06, 2020 at 11:24:13AM +0900, Masami Hiramatsu wrote:
> > Right, this is expected. The patch is based on jpoimboe/objtool/core,
> > which has extra commits.
> 
> Has that series already submitted to LKML? I need to look at the series too.
> Or, Josh, can you review it and if it is OK, please pick it to your series
> and send it.

I believe those patches were dropped from -tip because of a build issue.

Vasily, can you repost fixed versions of those patches, based on
tip/objtool/core, along with this new patch?

-- 
Josh

