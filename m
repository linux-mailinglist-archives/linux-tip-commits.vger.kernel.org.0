Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB741A5FE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Sep 2021 05:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhI1DUP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Sep 2021 23:20:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:47417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238795AbhI1DUP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Sep 2021 23:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632799102;
        bh=sMhuMTnngPM0UVYP6uaxBgEzAqjUHAW6jLcyZDyRrZ8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cXdlr5XxFjXowi3rs8+RsRSUAd08stQiZrf9nqNSRoVVQduzgY3TCri0ZPJvX9mx+
         iTBwMLh36LIWBdfp/C5SUexj8uy9IcJd8X63ZsSmW4AFCIkIyOYr/yoZDamyE8BNsu
         iLkGBhg5tIwdM6fts7VbxktkjdgLSI7/yvROeegg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.235]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1n32013wJo-00h9je; Tue, 28
 Sep 2021 05:18:22 +0200
Message-ID: <3dac2fe735de34497dc5fe465337f2d61bbf2a46.camel@gmx.de>
Subject: Re: [bisected] endless sd card reader polling in tip
From:   Mike Galbraith <efault@gmx.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 28 Sep 2021 05:18:21 +0200
In-Reply-To: <YVIIXKmrw02FS13T@zn.tnic>
References: <688ffe368375270f6e71f0bbfac9d004cfd39867.camel@gmx.de>
         <YVIIXKmrw02FS13T@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sgBEL70Gge8lSJyVytnxC2ERaEffGOYjps+SBCof5BA0UqBF9rj
 ffbkykCEAfYzUnIajeJ+vM4FKcSK9+K+Sx8++J3H0PfXvFu9+7ucM8sgEkm3Dv6Mo9MLaNL
 /0ailgndgD8T0XUDy+uPgCmKtlK8jGNCOqhu4+wEfgIviNhFo64fpQxAE33jw/BL6qkwNBE
 HFIxHtayghVKE8+OPoahA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aq96sejxiFA=:L0gKrWkS/loIRO7fejRKA/
 tpQQpzOp7SeHbgsoPsU2ftWsnKgINohR+LM9ZfD2RjQZbB7b5LU2N4tN8vP+LZkO9nolMJ/Mt
 UTKgqpCZgdf+pTfGZQqG2x8S6lUXrrYPJuWfGLerHHeZpJife66Y9/G/CU+39sXVZYC9lZpEk
 FuyMRpsp5B0b59rj+z9sel6tFqOl4ZX4UGXx82javvCrJonhUXfMSGtA/Tgwo4mG5R9JtoZQ4
 Wh99w9axQSGlr7cqkIeucmbdo5T/nJB8fTvoQ33NQhcZRVmdwD5bZHLQWpjd2Mb0v+kk8dUmL
 GcXmKHqsqPVOIEXDBBoRZQnzvlXPgtMAr+OEVdAJ9DvJEon97ofudGLG+9tLD/2ouhXiC1zNt
 21rYbnSq6bPn6GKrYqeP7IWOz8/e2eQEYrfEPEtf4TMsNtciZvvmKE7aKVCjIRw4kn5Z+l9fP
 i9SlB02LF24MkdH1ix9VTtvEkA8m9dROTXcaIf45c4NIXuZuS/M1kR3ehBkZ/V6nzDFPAl3KL
 3gM1Bih3k377FZnhdT4uRlu/GQZ8tgkCaksOv3UoYUZN7d9h+v47SvI+yNe8mrQtIW96kByhr
 yFqj0h1v1bcVbDZ/etYRu+pq9TEimqomrWrHh6Mcgm0mvTUJzTBF9Dy2HLOTyTp92JTUmnY4+
 gKCV/igg4MPDt9R/TdMbGKZojW0Rb1f//qyYdvU2UwPFRgU84H68dOLoK7JmDBEhldgObQ16I
 zPIpJ2loFWbeVTudGYhaC32/WDIGeASrl9+dAbVZ3FpRZ+GK/a728+W0157WI4goKjyjyRwz/
 71ijyA+xDAlVZy3O4NBEK9GKKA5I1eVHIt+FJ2rbMUM26xzfZhmwM3BbGPRh7Cc/w/ZynYgnV
 xfr6aS1OoR4Om2v2ocMYoYfrhDnir31QviNZQWhB6Vame2poUhV79JfdEd2V2lAphpkk2E936
 HcTcihxTvYyOuWtWw7oMQBPdtSXqTNTlj4hZzb6a/RfW2KWFNogWOUZPvqeDDjNtRz7xMIfBR
 DTfRkwvOMC+BCNnB5SWvb1VDLgL+JeEcfEkacu/qAUK1G0Q71tlPb7PiwQ3HlnrMIckrAhF9t
 0enVpUeEIxtBiw=
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, 2021-09-27 at 20:07 +0200, Borislav Petkov wrote:
> On Mon, Sep 27, 2021 at 06:56:39PM +0200, Mike Galbraith wrote:
> > I then perfectly cleanly bisected the little bugger to the below.
> > Mmm.. not convinced. Suggestions?
>
> Yah, that doesn't look like a tip commit to me. Hmm, maybe we've pulled
> in some broken stuff.

Well, looks like it's gotta be a timing Fairy tickling my hardware or
such.  Who knows, maybe the thing has been intermittently behaving this
way and the new to this cycle printk just made it visible.

I merged tip into master, and it works fine.  Thinking maybe there's a
merge artifact in the tip clone, I merged master into it, and diffed
the result of both merged trees - they're identical, and work fine.
Build freshly cloned tip/master (d478ddf4e3cf), and it's bad.

Elves 'n Gremlins, crap hardware, even crappier bios... <shrug>.

	-Mike
