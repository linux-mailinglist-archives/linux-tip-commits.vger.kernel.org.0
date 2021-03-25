Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9C349C4B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 23:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhCYWc2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhCYWcV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 18:32:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48663C06174A;
        Thu, 25 Mar 2021 15:32:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y5so3541318pfn.1;
        Thu, 25 Mar 2021 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KWr6YmeCPBgFiRrFsiGoA2C03PVzpKkKUx6udec6Wzg=;
        b=ly3RUg2yjRwQxI2vL5btgxJ7UXsk+e1NOwd+QE7oxEUCcXpzIOUqqxuHLdc0KLJ1OR
         EG/2XuTzcv9LoRylsxJZZHS4p7xRoAG2l+N5aQtVahW+atAV3df3c2Mcbw7MfMyYVwbq
         0m4IDcGrfcb5QBhQauiaP1TJxhaSbBZ8tZ05JL1FUDpUF9scesn7KAQNZcEZ9DpTXFpV
         GqkMgjUc+QuBeAninyH1+D5901+2wkFH4KyepESnlcgsbwOMG82dho8JDEJZYIpScntJ
         B4BPrxyfN8cFftefUqvpVXG8ra5bmMdEGhYqTUHYhSiVTWGsIhDv03eP4Ub8ih8drv4H
         sPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWr6YmeCPBgFiRrFsiGoA2C03PVzpKkKUx6udec6Wzg=;
        b=BDswrxY+lKPFF5V2gGZoFOcMM75ql/ecJXHpw8qVZb7qB+5XCfa6/3LJWAFKbTEnMi
         q1EnEF+/ZrjkGs/JgYRq72fY7pZBeBJbntggglLACtotVygaYD2lD69M1aLgyTR5gzMi
         MEkWoz0Ocst8Aeyrb1laARjRiSYvWwcMZ6l+kPH8hpjfLvlwWeACl6ifkqH7vIJZ4qxB
         RS+Byl+cjYGK6ge9DT0jZAfFnNAyzdO8PzHQLY/QI+mYIVJryX4j+LXTzay98Ag3g8G1
         wcQXMv6NXteBU+BWTg1FRdvyuj6Yis6Vj/ILNLqlk3L0hlgnQ21VOj/wSgM1gHIJlDQG
         +GnA==
X-Gm-Message-State: AOAM530d4xTQtMEitKItaf3QfkTJQpL+AYHAA3Ck2Eo7JCklLsw1lGqZ
        bcBKGE0GBVCULdgm/tUHSCQ=
X-Google-Smtp-Source: ABdhPJyCIicHrlr07TQJ1TPEOEr+B02s8/kbcng7MscHMQctksaRu7im4QFqN6NmXDvDv7HgIJN8RQ==
X-Received: by 2002:a63:1d52:: with SMTP id d18mr9632586pgm.403.1616711540794;
        Thu, 25 Mar 2021 15:32:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3991:e59d:d2d4:59dd])
        by smtp.gmail.com with ESMTPSA id w37sm6574783pgl.13.2021.03.25.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 15:32:19 -0700 (PDT)
Date:   Thu, 25 Mar 2021 15:32:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     tip-bot2 for Barry Song <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
Message-ID: <YF0PcJG4g1kMLZ25@google.com>
References: <20210302224916.13980-2-song.bao.hua@hisilicon.com>
 <161485523394.398.10007682711343433706.tip-bot2@tip-bot2>
 <87zgzj5gpo.fsf@nanos.tec.linutronix.de>
 <87o8fy69e0.fsf@nanos.tec.linutronix.de>
 <YFpvU30bKEZu0CSh@google.com>
 <87k0pvbtwf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0pvbtwf.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Mar 25, 2021 at 07:59:44AM +0100, Thomas Gleixner wrote:
> Dmitry,
> 
> On Tue, Mar 23 2021 at 15:44, Dmitry Torokhov wrote:
> > On Thu, Mar 04, 2021 at 07:50:31PM +0100, Thomas Gleixner wrote:
> >> Please hold on:
> >> 
> >>   https://lkml.kernel.org/r/CAHk-=wgZjJ89jeH72TC3i6N%2Bz9WEY=3ysp8zR9naRUcSqcAvTA@mail.gmail.com
> >> 
> >> I'll recreate a tag for you once rc2 is out.
> >
> > It looks like the change has been picked up as
> > cbe16f35bee6880becca6f20d2ebf6b457148552i on top of -rc2,
> > but I don't think there is tag for it?
> 
> Sorry, forgot about it. Here you go:
> 
>       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-no-autoen-2021-03-25

Thank you!

-- 
Dmitry
