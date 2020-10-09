Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24223289050
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbgJIRyl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731800AbgJIRyl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602266080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5lS/XyFlFyWGw8WTiJQaNa1adNpHA0kZZEkG97cs5w=;
        b=VKXH+QZ39cetvnsz2PX3zqS04LQ0tFDxiCXSD60GC9Unp06PFID2KAVuiVS5ThPlsB8k5L
        SviQ+lhQ4B8PPhpBPVHWJM+elLULqJo4NJSMKqxirqo+2ifWBuLC6B710RVZxi71yp5+Yc
        2+nXipv/rnyHXoms+4/HfkWy495sAJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-GNB71R8cMd2BnObDobOm0g-1; Fri, 09 Oct 2020 13:54:38 -0400
X-MC-Unique: GNB71R8cMd2BnObDobOm0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD283108E1A0;
        Fri,  9 Oct 2020 17:54:36 +0000 (UTC)
Received: from ovpn-66-175.rdu2.redhat.com (unknown [10.10.67.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA7119D7C;
        Fri,  9 Oct 2020 17:54:35 +0000 (UTC)
Message-ID: <942e0ffb37a4580982206d72404c521d72d38314.camel@redhat.com>
Subject: Re: [tip: locking/core] lockdep: Fix lockdep recursion
From:   Qian Cai <cai@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Boqun Feng <boqun.feng@gmail.com>
Date:   Fri, 09 Oct 2020 13:54:34 -0400
In-Reply-To: <e8fce9c0db7985e132262fd508a519ade656bdd8.camel@redhat.com>
References: <160223032121.7002.1269740091547117869.tip-bot2@tip-bot2>
         <e438b231c5e1478527af6c3e69bf0b37df650110.camel@redhat.com>
         <20201009135837.GD29330@paulmck-ThinkPad-P72>
         <20201009162352.GR2611@hirez.programming.kicks-ass.net>
         <e8fce9c0db7985e132262fd508a519ade656bdd8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, 2020-10-09 at 13:36 -0400, Qian Cai wrote:
> Back to x86, we have:
> 
> start_secondary()
>   smp_callin()
>     apic_ap_setup()
>       setup_local_APIC()
>         printk() in certain conditions.
> 
> which is before smp_store_cpu_info().
> 
> Can't we add a rcu_cpu_starting() at the very top for each start_secondary(),
> secondary_start_kernel(), smp_start_secondary() etc, so we don't worry about
> any printk() later?

This is rather irony. rcu_cpu_starting() is taking a lock and then reports
itself.

[    8.826732][    T0]  __lock_acquire.cold.76+0x2ad/0x3e0
[    8.826732][    T0]  lock_acquire+0x1c8/0x820
[    8.826732][    T0]  _raw_spin_lock_irqsave+0x30/0x50
[    8.826732][    T0]  rcu_cpu_starting+0xd0/0x2c0
[    8.826732][    T0]  start_secondary+0x10/0x2a0
[    8.826732][    T0]  secondary_startup_64_no_verify+0xb8/0xbb


