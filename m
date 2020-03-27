Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18D195D0E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Mar 2020 18:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0Rnn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 27 Mar 2020 13:43:43 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:34597 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Rnm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 27 Mar 2020 13:43:42 -0400
Received: by mail-pf1-f176.google.com with SMTP id 23so4852283pfj.1
        for <linux-tip-commits@vger.kernel.org>; Fri, 27 Mar 2020 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fRE9oC9WiHZwMVzNf52uYzsY+j5aMEpW5+lAh89aIM=;
        b=ZiaeSXMA1EVGJVd7a9CrsdW2+EuI+VqqWxqb2xjpSjj3Vn41dz8cbG5VY1IRksxXzo
         jDt0C8jD/1PK1FA9fPTqm4xVof1oA1E5M604DauGk7nA2vz4PCXagVXEiZiS41OjylQy
         5AswoKFNiKCdJlmNqDj3v0WEbzQpZrFW4i2Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fRE9oC9WiHZwMVzNf52uYzsY+j5aMEpW5+lAh89aIM=;
        b=kszyHBTPFv8rmCEHYmAjY0hZ0MXrMLjnbJphdWRAnhJC4pQLwwxxEboC/qGx4CK469
         MtrvvZtVupNeRhkMTgMUy2++4XxN9xmRkhQNe6ZoMASafAtAbF0OgpmP0c6MOsYwzH6r
         yKBFPHtkYbVVMumuPUYINbi4mWc/q+ZTJR+yrMAh07yd0JpmN9FaTxAZJ5dSkXkdiTMq
         JbG/IIzjiJq7NTWwHa6+lCSiqEP2X5cEgudyDsh22bOPHM/o0qJe99p88YKBiaVEeXkX
         dt3MM07w6WtFZQTqvaDKF8oMM3AtpuHjZTYvXIu6VyHvFxXMz37gU3Y9xppQHQpTD7lI
         BuYw==
X-Gm-Message-State: ANhLgQ0Tjy0I7sjtRggIQ2mwtHqAT9dgM8WR861tcFhPjBhWUlGSlvdt
        HO1ZGQzpEAqAkeLefGLJFCLsBQ==
X-Google-Smtp-Source: ADFU+vuNFYArnQxZChzKQFTXLl3l3wLcUHspaT0bjf+ZT62DMl+JtfSEttic0sSKcbYDg1Lw05+jfA==
X-Received: by 2002:aa7:943c:: with SMTP id y28mr342486pfo.52.1585331019698;
        Fri, 27 Mar 2020 10:43:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm4275778pje.9.2020.03.27.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:43:38 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:43:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/build] x86, vmlinux.lds: Add RUNTIME_DISCARD_EXIT to
 generic DISCARDS
Message-ID: <202003271042.10557C6413@keescook>
References: <20200326193021.255002-1-hjl.tools@gmail.com>
 <158530727545.28353.10694097580939655357.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158530727545.28353.10694097580939655357.tip-bot2@tip-bot2>
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Mar 27, 2020 at 11:07:55AM -0000, tip-bot2 for H.J. Lu wrote:
> The following commit has been merged into the x86/build branch of tip:
> [...]
> x86, vmlinux.lds: Add RUNTIME_DISCARD_EXIT to generic DISCARDS

Thanks! And just for note, I'll likely wait for -rc2 to resend the
orphan series -- I now depend on _three_ trees. ;) x86/boot, x86/build,
and arm. Heh

-- 
Kees Cook
