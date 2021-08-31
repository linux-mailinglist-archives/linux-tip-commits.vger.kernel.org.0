Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C563FCFC5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Sep 2021 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbhHaXEA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 19:04:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:60507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhHaXD7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 19:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630450970;
        bh=VMY9oIXrpgixVLgEGZSgjconPootgdM6kHEuUgEUwno=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IuTqikVePCEVSo9FlAAsyOcck+QTD2DWCBRUngy3vLmL3eRe77FQKOZ0YQqmboJbu
         1FK3eNDaNNYcH0BbqFn60pm5EtqIZbb0REM2bu2DLRsvN56BTQMyvMsIfMYD4F2LLa
         2X0wdIVk+hefWuYhsKDy8XfngCYTZ+yCoNA6P7cI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.4]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1mzFyu20GU-013iIT; Wed, 01
 Sep 2021 01:02:50 +0200
Message-ID: <6fbb733f35f058b1c1c64116bf7018d8ee56229e.camel@gmx.de>
Subject: Re: [tip: locking/urgent] locking/rwsem: Add missing __init_rwsem()
 for PREEMPT_RT
From:   Mike Galbraith <efault@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Date:   Wed, 01 Sep 2021 01:02:49 +0200
In-Reply-To: <163040368671.25758.17254317330050347174.tip-bot2@tip-bot2>
References: <50a936b7d8f12277d6ec7ed2ef0421a381056909.camel@gmx.de>
         <163040368671.25758.17254317330050347174.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9VE4g0BGlwZSag+QcJLm1h7Lsvjc+DWp/YMXLFsd959vsTD9b1h
 aCqeejMz6vNitk1PruvnsjNEkPrxqGlwxqAftdu7OOFyg8058btMDJNwOK0aVPV3AfdwX9r
 w7tPQ2dwlEt1M3UXhIoC8wrFt7WFlTBclK5FxSLtvqWT9JCtmswi3ON5quhZyCGje7+Udlr
 CUB8dI+Oc8zK+N5Lrrilw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qubAVZrw+vw=:ipEFZxi9EI3MV511nBRDPF
 1k+LFBhuNIneaIl6XFqkdAJW12FaAGEal6mHVGNS4Cn37hejzmev5FNvTyJUWU7ekjtE7pn6o
 beI8IjmEqxblxdn3QQbfd48msGOTePTsA7aYqJmS/MEURqiaLmnGwmyIZdjDtjGTsKK3WlhWI
 7wWZLGjTa02TyqreiTWgsch0wZr5Zxcnw3NpqECsy3aMqcvwYJkH31HKZNonhipa5JygW2wpQ
 iTXk8P0mumVVtUoEOi36vm2nW8Z0of552fx31AnyVNOEDY1pXcVM71GGCYAeydH7D/xw+AKhS
 q/zlPCSb/9gb0tJ1uRxi5kzDEUmPV04kvjRPsAmJwRiS2vwN19R4q61P1X9wfVC/N+b21RxHH
 /bqIuVAhCAozTaSkRMXAjGkxopDKTB6Eb/YPYgzwRu4DgdadqEY/iURladeRxjhs/sIWw9a5C
 S9U4XpZp+hB+trTdM5QczkAFj35MMcD5yrsTx9VVPkCQIrR2u0aLRT3RB0BPlkk3yp0DeyXJY
 DF37oClBBSjdm50YcXvvCqBVHyMSrVr3PjDYkSj6tQkA6HY8DvwFxwX38yBWmpuR3AbeieZ8/
 Q/kdQs9ONqmWVePhUawIqPmEF9Dqnf23AcJ5yyO/q086+u9FBbPDyVV2LM1DmOAxxbODI+YbD
 94X2jaGDNjHX8dRBFnd0s888uRCLombnl9AgX+AMPxeU8GAt/6FsDPr2LXCN2K3fUKaQJ2NBd
 TwHQJe6EbK3OPeJXxiBAzlkOOUgZHwlmiFWTKxepWzbSAQ0koPnjwrr//5NWqukiJ58y30C4+
 VNf7WLdDBhPWguYft9CyYXOrswDvrldf9gwkAkHrs+lTWNrxtZMZ3yZMakIZ2/UnosebAmNXd
 aYUyzGQPPBAe08FqJv9s884cFlrPn3aIaEhP4o0ZNaIS6QUdCOCLKW9XSWJ23ahHPmA5xd3oP
 fj7qJzruuxaNO0s4qDzMKuUT4t7qPPbjWafAyvu+QsmyP7MED1mMBXBF/byeYGLReRiMu1TYd
 U2Q64Nb3nr/aKjvUjNim7lnmZTCIcwSc3oarSep3163//gdStoNGRWW2C7EpZXQN5K2a+Dxm7
 psLyJc8I7RSZ1it2BcrkLFPxR9+KxLC3N4S
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, 2021-08-31 at 09:54 +0000, tip-bot2 for Mike Galbraith wrote:
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1376,15 +1376,17 @@ static inline void __downgrade_write(struct rw_s=
emaphore *sem)
> =C2=A0
> =C2=A0#include "rwbase_rt.c"
> =C2=A0
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> =C2=A0void __rwsem_init(struct rw_semaphore *sem, const char *name,
        ^^^^^^^^^^^^ this line dodged your key tapping.

	-Mike
